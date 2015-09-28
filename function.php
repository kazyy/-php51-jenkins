<?php

define('__DIR__', dirname(__FILE__));

function sys_get_temp_dir() {
    return "/tmp";
}

function spl_object_hash($object)
{
    if (is_object($object)) {
        ob_start(); var_dump($object); $dump = ob_get_contents(); ob_end_clean();
        if (preg_match('/^object\(([a-z0-9_]+)\)\#(\d)+/i', $dump, $match)) {
            return md5($match[1] . $match[2]);
        }
    }
    trigger_error(__FUNCTION__ . "() expects parameter 1 to be object", E_USER_WARNING);
    return null;
}
