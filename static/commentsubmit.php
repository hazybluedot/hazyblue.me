<?php

// commentsubmit.php -- Receive comments and e-mail them to someone
// Copyright (C) 2011 Matt Palmer <mpalmer@hezmatt.org>
//
//  This program is free software; you can redistribute it and/or modify it
//  under the terms of the GNU General Public License version 3, as
//  published by the Free Software Foundation.
//
//  This program is distributed in the hope that it will be useful, but
//  WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
//  General Public License for more details.
//
//  You should have received a copy of the GNU General Public License along
//  with this program; if not, see <http://www.gnu.org/licences/>


// Format of the date you want to use in your comments.  See
// http://php.net/manual/en/function.date.php for the insane details of this
// format.
$DATE_FORMAT = "Y-m-d H:i";

// Where the comment e-mails should be sent to.  This will also be used as
// the From: address.  Whilst you could, in theory, change this to take the
// address out of the form, it's *incredibly* highly recommended you don't,
// because that turns you into an open relay, and that's not cool.
$EMAIL_ADDRESS = "comment@hazyblue.me";

// The subject of all blog comment e-mails.  If you're running lots of these,
// you might want to customise it, or if you were running a generic comment
// handler you could take it out of the form, but really, who cares what your
// comment e-mails are titled, as long as you can recognise it?
$SUBJECT = "Blog comment received";

// The contents of the following file (relative to this PHP file) will be
// displayed after the comment is received.  Customise it to your heart's
// content.
$COMMENT_RECEIVED = "/comment_received/index.html";

$BOTGUARD_FIELD = "foo_name";

/****************************************************************************
 * HERE BE CODE
 ****************************************************************************/

if (!$_POST) {
	$data = array('typpe'=>'error', 'text'=>'check API');
	header('Content-Type: application/json');
	echo json_encode($data);
	exit();
}

//file_put_contents("/tmp/post.log", print_r($_POST,true));

$post_id = $_POST["post_id"];
unset($_POST["post_id"]);
$comment = $_POST["comment"];
unset($_POST["comment"]);
$botguard="";
if (isset($_POST["$BOTGUARD_FIELD"])) {
    $botguard = $_POST["$BOTGUARD_FIELD"];
    unset($_POST["$BOTGUARD_FIELD"]);
}

$use_json = False;
if (isset($_POST["use_json"])) {
   $use_json = True;
   unset($_POST["use_json"]);
}

//if (isset($_POST['name'])) {
//    $SUBJECT = "Blog comment received from $_POST['name']";
//}

if (!empty($botguard)) {
   //Spam managed
   header( "Location: $COMMENT_RECEIVED" );
   exit();
}

$headers = array('Content-type: text/plain; charset=UTF-8; format=flowed');
array_push($headers, "From: $EMAIL_ADDRESS");

$meta = array("post_id: $post_id", "created_at: " . date($DATE_FORMAT) );

$received = array();

$received['created_at'] = date($DATE_FORMAT);
$received['comment'] = $comment;

foreach ($_POST as $key => $value) {
	if (strstr($value, "\n") != "") {
		// Value has newlines... need to indent them so the YAML
		// looks right
		$value = str_replace("\n", "\n  ", $value);
	}
	// It's easier just to single-quote everything than to try and work
	// out what might need quoting
	$value = "'" . str_replace("'", "''", $value) . "'";
        array_push($meta, "$key: $value");
        $received[$key] = $value;
}

$msg = "---\n" . implode("\n", $meta) . "\n---\n$comment";

$result = array('type'=>'error', 'text'=>'unknown error', 'status'=>-1);

if (mail($EMAIL_ADDRESS, $SUBJECT, $msg, implode( "\r\n", $headers) ))
{
        $result = array('type'=>'message', 'text' => 'awaiting moderation', 'received'=>$received, 'status'=>0);
}
else
{
        $error = "There was a problem sending the comment. Please contact the site's owner.";
        $result = array('type'=>'error', 'text'=>$error, 'status'=>0);
}

//if ($use_json) {
     	header('Content-Type: application/json');
	echo json_encode($result);
//} else {        
//    header( "Location: $COMMENT_RECEIVED" );
//}

exit(0);
