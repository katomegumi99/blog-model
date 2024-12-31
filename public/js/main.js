$(function () {

    function loadAbout() {
        $('.center').empty();
        $('.center').load('/about.html');
    }

    let user = JSON.parse(localStorage.getItem('user'));
    // 将 token 存入 header
    $.ajaxSetup({
        headers: {
            'Authorization': user.token
        }
    });
    if (!user) {
        window.location.href = '/login.html';
    } else {
        $('#username').text(user.username);
    }

    $('#logout').click(function () {
        localStorage.removeItem('user');
        window.location.href = '/login.html';
    })

    $('#addArticleBtn').click(function () {
        $('.center').empty();
        $('.center').load('/writeArticle.html');
    })

    // 关闭模态框
    $('#closeModalBtn').click(function () {
        $('#modalOverlay').hide();
    });

    // 点击背景层关闭模态框
    $('#modalOverlay').click(function (event) {
        if (event.target.id === 'modalOverlay') {
            $('#modalOverlay').hide();
        }
    });

    $('#publishBtn').click(function () {
        let comment = $('#articleComment').val();
        if (comment.trim() === '') {
            alert('评论不能为空');
            return;
        } else {
            let article_id = $('#publishBtn').attr('article_id');
            $.post("/api/comment/addComment", { post_id: article_id, comment: comment.trim(), user_id: user.id }, function (data) {
                $('#modalOverlay').hide();
                console.log(data);
                alert('评论成功');
            }).fail(function (error) {
                console.log(error);
                alert('评论失败');
            });
        }
    })

    $('.sidebar a').click(function () {
        $('.sidebar a').removeClass('active');
        $(this).addClass('active');
        switch ($(this).attr('id')) {
            case 'home':
                loadArticles();
                break;
            case 'articles':
                loadMyArticles();
                break;
            case 'favorites':
                loadFavoriteArticles();
                break;
            case 'followings':
                loadFollowings(user.id);
                break;
            case 'followers':
                loadFollowers(user.id);
                break;
            case 'about':
                loadAbout();
                break;
            default:
                break;
        }
    })

    loadArticles();


    window.addComment = function (event, id) {

        $('#modalOverlay').show();
        console.log(id);
        $('#publishBtn').attr('article_id', id);
        event.stopPropagation();
    }

    window.onLike = function (event, id) {
        console.log(id);
        event.stopPropagation();
        $.post("/api/like/setLike", { post_id: id, user_id: user.id }, function (data) {

            let count = $('#like-count-' + id).text().split(' ')[1] - 0;
            if (data.code == 200) {
                $('#like-count-' + id).text("点赞 " + (count + 1));
            } else {
                $('#like-count-' + id).text("点赞 " + (count - 1));
            }
        }).fail(function (error) {
            alert('点赞失败');
        });
    }

    window.onFavorite = function (event, id) {
        console.log('click favorite', id);
        event.stopPropagation();
        $.post("/api/favorite/setFavorite", { post_id: id, user_id: user.id }, function (data) {

            let count = $('#favorite-count-' + id).text().split(' ')[1] - 0;
            if (data.code == 200) {
                $('#favorite-count-' + id).text("收藏 " + (count + 1));
            } else {
                $('#favorite-count-' + id).text("收藏 " + (count - 1));
            }
        }).fail(function (error) {
            alert('点赞失败');
        });
    }



    window.articleDetail = function (id) {
        console.log('articleDetail', id);
        $('.center').empty();
        $.post('/api/article/articleDetail', { "id": id - 0 }, (data) => {
            let { article, comments, user } = data
            console.log(user, article, comments)
            let articleHtml = `<div class="author circular-icon" data-user='${JSON.stringify(user)}'>${user.username}</div><h1>${article.title}</h1><p>${article.content}</p>`
            $('.center').append($(articleHtml))
            $('.center').append($("<div id='comments'><h2>评论</h2></div>"))
            comments.forEach(element => {
                let user = {
                    username: element.author_username,
                    id: element.user_id,
                    email: element.author_email
                }
                let commentHtml = ` <div class="comment">
                <h4 class="author" data-user='${JSON.stringify(user)}'>${element.author_username}</h4> at ${element.comment_created_at}
                <p>${element.comment_content}</p> </div>`
                $('#comments').append($(commentHtml))
            });
            $('.center').append($("<div class='usertip'><h3>user</h3><p>你的主页显示</p><button id='foucsBtn'>关注</button></div>"))

            $('.author').hover(function (event) {
                let fuser = JSON.parse($(this).attr('data-user'));
                let user = JSON.parse(localStorage.getItem('user'));
                if (fuser.id != user.id) {
                    $('.usertip').css({
                        // display: 'block',
                        top: event.clientY - 50,
                        left: event.clientX + 20
                    });
                    $('.usertip').stop(true, true).fadeIn(300);
                    $('.usertip').find('h3').text(fuser.username)
                    $('.usertip').find('p').text(fuser.email)
                    $('.usertip').find('#foucsBtn').click(function () {
                        console.log('关注', fuser.id)
                        $.post('/api/follow/addFollow', { "followId": user.id, userId: fuser.id }, (data) => {
                            console.log(data)
                            if (data.code == 200) {
                                alert('关注成功')
                            } else {
                                alert('关注失败')
                            }
                        })
                    })
                }
            }, function () { });
            // 点击关闭按钮时隐藏关注框
            $('#foucsBtn').click(function () {
                $('.usertip').stop(true, true).fadeOut(300);
            });
            // 可选：当鼠标移出关注框时也隐藏它（如果用户没有点击关闭按钮）
            $('.usertip').mouseleave(function () {
                // $('#closeBox').click(); // 触发关闭按钮的点击事件来隐藏关注框
                $('.usertip').stop(true, true).fadeOut(300);
            });

        })
    }

})