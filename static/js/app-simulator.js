/* App simulator — menu navigation and child form display.
 * Expects: appCats (array), mainX (int), greetNames (array) defined before this script loads.
 */
var openCat=-1,popup=document.getElementById("app-popup"),
    childEl=document.getElementById("app-child");
var cw=+childEl.dataset.cw;
document.querySelectorAll(".app-label").forEach(function(el){
  el.addEventListener("click",function(e){
    e.stopPropagation();
    var ci=+this.dataset.cat;
    if(openCat===ci){closePopup();return}
    openCat=ci;
    var cat=appCats[ci],lbl=cat.label,h="";
    cat.items.forEach(function(it,i){
      if(it.type==="secret")return;
      h+='<div class="app-mi" data-ci="'+ci+'" data-ii="'+i+'">'+
        it.caption.replace(/</g,"&lt;")+'</div>';
    });
    popup.innerHTML=h;
    popup.style.left=(lbl.left+3)+"px";
    popup.style.top=(lbl.top+lbl.height+6)+"px";
    popup.style.display="block";
    popup.querySelectorAll(".app-mi").forEach(function(mi){
      mi.addEventListener("click",function(ev){
        ev.stopPropagation();
        showChild(appCats[+this.dataset.ci].items[+this.dataset.ii]);
        closePopup();
      });
    });
  });
});
document.addEventListener("click",function(){closePopup()});
function closePopup(){popup.style.display="none";openCat=-1}
function showChild(it){
  var cap=it.caption.replace(/</g,"&lt;");
  var bar='<div class="app-ct">'+cap+' <button onclick="hideChild()" title="Close">✕</button></div>';
  if(!it.image){
    childEl.innerHTML=bar+'<div class="app-noshot">&#x1f4f7; Screenshot not captured &mdash; dialog overlapped main form</div>';
    return;
  }
  var h=it.ch?'height:'+it.ch+'px;':'';
  var bar='<div class="app-ct">'+cap+' <button onclick="hideChild()" title="Close">✕</button></div>';
  if(it.caption==="Greets"&&greetNames.length){
    var names=greetNames.map(function(n){return'<span>'+n+'</span>'}).join('');
    childEl.innerHTML=bar+
      '<div class="app-cc app-greets" style="max-width:'+cw+'px;'+h+'"><img src="'+it.image+'" style="max-width:none">'+
      '<div class="greets-scroll"><div class="greets-track">'+names+names+'</div></div></div>';
  } else {
    childEl.innerHTML=bar+
      '<div class="app-cc" style="max-width:'+cw+'px;'+h+'"><img src="'+it.image+'" style="max-width:none"></div>';
  }
}
function hideChild(){childEl.innerHTML=""}
