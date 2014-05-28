var hbd = {
    makeGravatar: function(email) {
        return $('<img>').attr({src: 'http://www.gravatar.com/avatar/' + MD5(email) + '?size=75'});
    },
    
    makeVcard: function( data ) {
        var vcard = $('<div/>', 
                      { "class": "vcard" });
        vcard.append( $('<span class="photo">' ).append( hbd.makeGravatar(data.email) ) );
        vcard.append('<span class="fn">'+data.name+'</span>');
        vcard.append('<time>Some time in the future</time>');

        return vcard;
    },

    makePostData: function(formObject) {
        var name    = $('input[name=name]').val();
        var email   = $('input[name=email]').val();
        var comment = $('textarea[name=comment]').val();
        var website = $('input[name=website]').val();

        return {
            'email': email,
            'name': name,
            'website': website,
            'comment': comment
        };
    },

    makeComment: function(data) { 

        var commentObj = $( "<article/>", {
            "class": "comment pending",
            html: '<header></header>' + '<section class="main">' + data.comment + '</section>'
        });

        commentObj.find( 'header' ).append( hbd.makeVcard( data ) );
        commentObj.data( 'md5id', MD5(data.comment) );
        
        return commentObj;
    },

    commentIds: function() {
        $( 'article.comment' ).each(function() {
            var comment = $( this );
            var comment_msg = comment.find('p').html();
            comment.data( "md5id", MD5(comment_msg) );
        });
    },

    findComment: function(id) {
        return $( 'article.comment' ).filter(function() {
            return $( this ).data('md5id') === id;
        });
    },
    
    onReady: function(){
        hbd.commentIds();

        $( 'article.comment' ).each(function() {
            var item = $( this );
            console.log( "md5: " + item.data('md5id') );
        });

        $( "form#comment_form" ).submit(function( eventObject ) {
            
            var post_data = hbd.makePostData( $(eventObject.target) );
            var comment = hbd.makeComment(post_data)
            
            if ( hbd.findComment(comment.data('md5id')).length ) {
                $( '#post_result' ).hide().html('<div class="alert">You already posted that!</div>').slideDown();
            } else {
                comment.appendTo( $( "div#comments" ) ).slideDown();
            }
            /*
            $.post('/assets/commentsubmit.php', post_data, function(response) {
                if ( response.type == 'error' )
                {
                    output = '<div class="error">'+response.text+'</div>';
                    $("#result").hide().html(output).slideDown();
                } else {
                    //var comment = makeComment();
                    //$( "div#comments" ).append( comment ).slideDown();
                    console.log('successfully posted comment');
                }
            }, 'json');
            */
            eventObject.preventDefault();
        });
    }
};

var nav = {
    showSidebar: function() {
        $( 'body' ).toggleClass("active");
    },
    
    onResize: function() {
        var off_canvas_nav_display = $('.off-canvas-navigation').css('display');
        if (off_canvas_nav_display === 'block') {
            $("body").removeClass("active");
        }
    },

    toggle: function() {
        $('#sidebar_button').click(function(e) {
            e.preventDefault();
            nav.showSidebar();
            
            /*
            var body_classes = $( 'body' ).attr('class').split(/\s+/)
            if ( $.inArray('active', body_classes) != -1 ) {
                $(e.target).html("\u2715");
            } else {
                $(e.target).html("\u2630");
            }
            */
        });
    }
};

var site = {
    onReady: function() {
        hbd.onReady();
        nav.toggle();
    }
}

$( document ).ready( site.onReady );

$( window ).resize( nav.onResize );
