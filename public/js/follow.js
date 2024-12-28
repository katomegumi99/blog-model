$(function () {
    window.loadFollowings = function (id) {
        console.log('load followings');
        $.post('/api/follow/getFollowings', { userId: id }, function (data) {
            console.log(data);
            var $ul = crearteUsersList(data.data);
        }).catch(function (error) {
            alert('加载失败');
        });
    };

    window.loadFollowers = function (id) {
        $.post('/api/follow/getFollowers', { userId: id }, function (data) {
            console.log(data);
            crearteUsersList(data.data);
        }).catch(function (error) {
            alert('加载失败');
        });
    };

    function crearteUsersList(users) {
        $(".center").empty();
        var $table = $("<table class='table table-bordered'></table>");
        var $thead = $("<thead><tr><th>ID</th><th>用户名</th><th>邮箱</th></tr></thead>");
        $table.append($thead);
        var $tbody = $("<tbody></tbody>");
        $.each(users, function (i, user) {
            var $tr = $("<tr><td>" + user.id + "</td><td>" + user.username + "</td><td>" + user.email + "</td></tr>");
            $tbody.append($tr);
        });
        $table.append($tbody);
        $(".center").append($table);
    }
});
