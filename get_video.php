<?php
header("Content-Type: video/flv");

echo file_get_contents('./video.flv');
?>