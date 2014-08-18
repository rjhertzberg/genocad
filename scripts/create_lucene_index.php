<?php
// This script handles the creation and population of the Zend/Lucene Index
// for the GenoCAD Parts database

set_include_path('/var/www/genocad/zend/library/');

include_once "Zend/Search/Lucene/Analysis/Analyzer.php";
include_once "Zend/Search/Lucene/Analysis/Analyzer/Common/TextNum.php";
include_once "Zend/Search/Lucene.php";
include_once "Zend/Search/Lucene/Document.php";
include_once "Zend/Search/Lucene/Field.php";

$indexPath = "/opt/lucene/data/";
$server = "localhost";
$username="genofab";
$password="2aC4uRv4aL1hYn4poz7er2ghakS4Og2I2";
$database="genofab";

Zend_Search_Lucene_Analysis_Analyzer::setDefault(new Zend_Search_Lucene_Analysis_Analyzer_Common_TextNum_CaseInsensitive());
$index = Zend_Search_Lucene::create($indexPath);

mysql_connect($server,$username,$password, $database);

@mysql_select_db($database) or die( "Unable to select database");

$query="SELECT * FROM parts";

$result = mysql_query($query);

$total_rows = mysql_numrows($result);

for ($i = 0; $i < $total_rows; $i++) {

    $doc = new Zend_Search_Lucene_Document();
    $doc->addField(Zend_Search_Lucene_Field::Keyword('part_id_pk', mysql_result($result,$i,"id")));
    $doc->addField(Zend_Search_Lucene_Field::UnStored('sequence', mysql_result($result,$i,"segment")));
    $doc->addField(Zend_Search_Lucene_Field::Text('part_id', mysql_result($result,$i,"part_id")));
    $doc->addField(Zend_Search_Lucene_Field::Text('part_name', mysql_result($result,$i,"description")));
    $doc->addField(Zend_Search_Lucene_Field::Text('user_id', mysql_result($result,$i,"user_id")));
    $doc->addField(Zend_Search_Lucene_Field::Text('description', mysql_result($result,$i,"description_text")));

    // add the Grammar / Category list to the document

    $cat_query = "SELECT distinct concat(g.grammar_id, '|', g.name, '|', c.letter, '|', c.description) as category  FROM categories_parts cp, categories c, grammars g where cp.category_id = c.category_id and c.grammar_id = g.grammar_id and cp.part_id = " . mysql_result($result,$i,"id");
    $cat_result = mysql_query($cat_query);
    $cat_rows = mysql_numrows($cat_result);
    $category = "";

    for ($j = 0; $j < $cat_rows; $j++) {
        if ($j > 0) {
            $category .= ';';
        }
        $category .= mysql_result($cat_result, $j, "category");
    }
    $doc->addField(Zend_Search_Lucene_Field::Text('category', $category));

    $index->addDocument($doc);

}
mysql_close();

//$index->commit();

?>
