/* Tab explorer — switch panels and toggle screenshot visibility */
function wtTab(b,ci){
  b.parentElement.querySelectorAll('.wt-tab').forEach(function(x){x.classList.remove('active')});
  b.classList.add('active');
  document.querySelectorAll('.wt-panel').forEach(function(p,i){p.style.display=i===ci?'':'none'});
}
function wtShow(el){
  var i=el.querySelector('.wt-img');
  if(i) i.style.display=i.style.display==='none'?'':'none';
}
