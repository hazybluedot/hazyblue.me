if (!window.console) console = {log: function(msg) {}};

var hbd = {
    makeGravatar: function(email) {
        return $('<img>').attr({src: 'http://www.gravatar.com/avatar/' + MD5(email) + '?size=75'});
    },
    
    makeVcard: function( data ) {
        var vcard = $('<div/>', 
                      { "class": "vcard" });
        vcard.append( $('<span class="photo">' ).append( hbd.makeGravatar(data.email) ) );
        vcard.append('<span class="fn">'+data.name+'</span>');

        return vcard;
    },

    makePostData: function(formObject) {
        var name    = $('input[name=name]').val();
        var email   = $('input[name=email]').val();
        var comment = $('textarea[name=comment]').val();
        var website = $('input[name=website]').val();
        var post_id = $('input[name=post_id]').val();

        return {
            'post_id': post_id,
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

        var headerObj = commentObj.find( 'header' );
        headerObj.append( hbd.makeVcard( data ) );
        headerObj.append('<time pubtime>' + data.created_at + '</time>');
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
    
    onSuccess: function(response) {
        if ( response.type == 'error' )
        {
            output = '<div class="error">'+response.text+'</div>';
            $( '#post_result' ).hide().html(output).slideDown();
        } else { 
            var comment = hbd.makeComment(response.received);
            comment.insertBefore( $( ".comment-form" ) ).slideDown();
        }
    },
    
    onReady: function(){
        hbd.commentIds();

        $('<input/>', {
            type: 'hidden',
            name: 'use_json',
            value: 'true',
        }).insertAfter( $('#post_result') );

        $( "#comment_form" ).submit(function( eventObject ) {
            
            eventObject.preventDefault();
            var post_data = hbd.makePostData( $(eventObject.target) );
            var comment = hbd.makeComment(post_data);
            
            if ( hbd.findComment(comment.data('md5id')).length ) {
                $( '#post_result' ).hide().html('<div class="alert">You already posted that!</div>').slideDown();
                return 0;
            } 

            $.post('https://www.hazyblue.me/assets/commentsubmit.php', post_data, hbd.onSuccess, 'json').error(function(e) { 
                console.log(e); 
            });

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
    },

    onReady: function() {
        $('.popup').click(function(event) {
            event.preventDefault();
            window.open($(this).attr("href"), "popupWindow", "width=550,height=420,scrollbars=yes");
        });
    }
};

var analytics = {
    onReady: function() {
        var _paq = _paq || [];
        _paq.push(['trackPageView']);
        _paq.push(['enableLinkTracking']);
        (function() {
            var u=(("https:" == document.location.protocol) ? "https" : "http") + "://www.hazyblue.me/piwik/";
            _paq.push(['setTrackerUrl', u+'piwik.php']);
            _paq.push(['setSiteId', 1]);
            var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0]; g.type='text/javascript';
            g.defer=true; g.async=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
        })();
    }
}

var site = {
    onReady: function() {
        hbd.onReady();
        nav.onReady();
        nav.toggle();
    }
}

$( document ).ready( site.onReady );

$( window ).resize( nav.onResize );
