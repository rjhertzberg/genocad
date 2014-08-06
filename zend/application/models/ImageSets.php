<?php

class Application_Model_ImageSets
{

    /**
     * Returns the physical path of the base directory where images are stored on 
     * the server.  This path is set in the application.ini configuration file.
     * 
     * @return String
     */
    public static function getBaseDir() {
        return (Zend_Registry::get('config')->grammar->images->base_dir);
    }

    /**
     * Returns the relative url of the base directory where images are stored on 
     * the server.  This url is set in the application.ini configuration file.
     * 
     * @return String
     */
    public static function getBaseUrl() {
        return (Zend_Registry::get('config')->grammar->images->base_url);
    }

    /**
     * Returns an array of valid extensions for images as specified in the configuration file
     * 
     * @return Array
     */
    public static function getExtensions() {
        return (explode(',', Zend_Registry::get('config')->grammar->images->extensions));
    }

    /**
     * Returns the subfolder name where the standard images are stored. This path 
     * is set in the application.ini configuration file.
     * 
     * @return String
     */
    public static function getImageSubfolder() {
        return (Zend_Registry::get('config')->grammar->images->image_sub_folder);
    }

    /**
     * Returns the subfolder name where the icon version of the images are stored. 
     * This path is set in the application.ini configuration file.
     * 
     * @return String
     */
    public static function getIconSubfolder() {
        return (Zend_Registry::get('config')->grammar->images->icon_sub_folder);
    }

    /**
     * Returns the full physical path of the directory where the standard images
     * are stored for the given image set.
     * 
     * @param String $set_name - the name of the image set
     * 
     * @return String
     */
    public static function getImageSetPath($set_name) {
        return (sprintf("%s/%s/%s/", self::getBaseDir(), $set_name, self::getImageSubfolder()));
    }

    /**
     * Returns the full physical path of the directory where the icon version of
     * the images are stored for the given image set.
     * 
     * @param String $set_name - the name of the image set
     * 
     * @return String
     */
    public static function getImageSetIconPath($set_name) {
        return (sprintf("%s/%s/%s/", self::getBaseDir(), $set_name, self::getIconSubfolder()));
    }
    
    /**
     * Returns the base URL that will be used to access the standard images
     * for the given image set.
     * 
     * @param String $set_name - the name of the image set
     * 
     * @return String
     */
    public static function getImageSetUrl($set_name) {
        return (sprintf("%s/%s/%s/", self::getBaseUrl(), $set_name, self::getImageSubfolder()));
    }
    
    
    /**
     * Returns the base URL that will be used to access the icon version of the
     * images for the given image set.
     * 
     * @param String $set_name - the name of the image set
     * 
     * @return String
     */
    public function getImageSetIconUrl($set_name) {
        return (sprintf("%s/%s/%s/", self::getBaseUrl(), $set_name, self::getIconSubfolder()));
    }

    /**
     * Returns an array of the available image set names.
     * 
     * @return Array
     */
    public static function getImageSets() {

        $path = self::getBaseDir() . '/';
        $set = Array();

        /**
         * opens the image set base directory and loops through the folder to
         * retrieve subfolders.  Each subfolder is added to the $set array.
         */
        if ($handle = opendir($path)) {

            while (false !== ($file = readdir($handle))) {
                if (is_dir($path . $file) && !(substr($file, 0, 1) == '.')) {
                    $set[] = $file;
                }
            }
            closedir($handle);
        }
        return ($set);

    }

    /**
     * Returns a two-dimensional array of images that exist in the given image 
     * set.  Each element of the array consists of an array with the file name,
     * physical path (including the file name) and the relative url of the image. 
     * 
     * @param $set_name - the name of the image set
     * 
     * @return Array
     */
    public static function getImageSetImages($set_name) {

        $path = self::getImageSetPath($set_name);
        $images = Array();

        if ($handle = opendir($path)) {
        
            /**
             * Loop through the image set folder and retrieve images that have
             * a valid image extension.
             */
            while (false !== ($file = readdir($handle))) {
                // determine the extension of the file
                $ext = substr($file, -4);

                // Make sure the "file" is not a subdirectory and it has a valid extension. 
                if (!is_dir($path . '/' . $file) && in_array($ext, self::getExtensions())) {
                    $images[] = array(
                                    'name' => $file,
                                    'path' => $path . '/' . $file,
                                    'url'  => self::getImageSetUrl($set_name) . '/' . $file,
                                );
                }
            }
            closedir($handle);
        }

        return ($images);
    }

    public static function getDefaultImageUrl() {
        return (self::getBaseUrl() . '/default.png');
    } 

    public static function getDefaultIconUrl() {
        return (self::getBaseUrl() . '/default_icon.png');
    } 
    
    /**
     * Returns true/false if the $set_name exists
     * 
     * @param string $set_name
     * @return boolean
     * 
     */
    public static function exists ($set_name) {
        // using array_map to convert the image set array to lowercase in order
        // to acheive a case-insensitive array search
        return (in_array(strtolower($set_name), array_map('strtolower', self::getImageSets())));
    }


    /**
     * 
     * @param $zipFile
     * @param $destination
     */
    public static function createFromZip($zipFile, $destination) {

        $path = self::getBaseDir() . '/' . $destination;

        if (!(self::exists($destination))) {
            mkdir($path);
        	mkdir($path . '/' . self::getImageSubfolder());
        	mkdir($path . '/' . self::getIconSubfolder());
        }

        $zip = new ZipArchive();
        if ($zip->open($zipFile) === true) {
            for($i = 0; $i < $zip->numFiles; $i++) {
                $file = explode('/', $zip->getNameIndex($i));
                if ($file[0] == 'icon_set') {
                    $filename = $zip->getNameIndex($i);
                    $fileinfo = pathinfo($filename);
                    copy("zip://".$zipFile."#".$filename, $path . '/' . $file[2] . '/'. $fileinfo['basename']);
                }
            }                  
            $zip->close();                  
        }

    }

}
