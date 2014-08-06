<?php
class Genocad_Utilities_RowToXML
{

    public static function append(&$row, &$node) {
    
        foreach ($row->toArray() as $key => $value) {
            if ($row->getTable()->isIdentity($key)) {
                $node->addAttribute($key, $value);
            }
            $node->addChild($key, str_replace(' & ', ' and ', $value));
        }

    }

}