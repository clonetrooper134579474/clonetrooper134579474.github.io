<?php
header("Content-Type: video/flv");
header('Content-Length: ' . filesize('get_video.flv'));
readfile('get_video.flv');
?>
