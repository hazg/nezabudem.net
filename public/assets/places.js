(function(){var e,t=function(e,t){return function(){return e.apply(t,arguments)}};e=function(){function e(e){this.prepare_controls=t(this.prepare_controls,this),this.update_form=t(this.update_form,this),this.set_placemark=t(this.set_placemark,this),this.show_places=t(this.show_places,this),this.prepare_templates=t(this.prepare_templates,this);var n=this;window.place_map=this,e.can!=="undefined"&&(this.can=e.can),typeof ymaps!="undefined"&&ymaps!==null&&ymaps.ready(function(){var t,r,i;return n.prepare_templates(),n.prepare_controls(),t=[ymaps.geolocation.latitude,ymaps.geolocation.longitude],e.center?t=e.center:window.ym_model&&$("#"+ym_model+"_lat").val()>0&&(t=[$("#"+window.ym_model+"_lat").val(),$("#"+window.ym_model+"_lng").val()]),i=10,e.zoom&&(i=e.zoom),n.map=new ymaps.Map("map",{center:t,zoom:i,type:"yandex#map",behaviors:["default","scrollZoom"]}),n.map.options.set("balloonContentBodyLayout","my#map-balloon"),n.map.behaviors.get("dblClickZoom").disable(),n.collection=new ymaps.GeoObjectCollection,n.clusterer=new ymaps.Clusterer,n.clusterer.options.set({gridSize:32}),e.show_all?n.show_places(n.map.getBounds(),0):(n.placemark=new ymaps.Placemark(t,{},{iconImageHref:"/images/landmark-obelisk.png",iconImageSize:[32,60],iconImageOffset:[-15,-60]}),n.map.geoObjects.add(n.placemark),n.show_places(n.map.getBounds(),0,e={iconImageHref:"/images/landmark-obelisk-trans.png",iconImageSize:[15,28],iconImageOffset:[-7,-14]})),e.show_wikimapia&&(r={balloonContentBodyLayout:"my#wikimapia-balloon"},n.wikimapia_collection=new ymaps.GeoObjectCollection(!1,r),n.map.geoObjects.add(n.wikimapia_collection),n.show_wikimapia_objects(n.map.getBounds()),n.map.events.add("boundschange",function(e){if(!n.map.balloon.isOpen())return n.show_wikimapia_objects(e.get("newBounds"))})),n.map.controls.add("typeSelector").add("zoomControl").add("mapTools"),n.can==="edit"&&n.map.events.add("click",function(e){return n.balloon_pos=e.get("coordPosition"),window.mcp=n.balloon_pos,n.map.balloon.open(n.balloon_pos)}),n.map.balloon.events.add("open",function(e){return $("#set_placemark").unbind("click").click(function(t){return n.set_placemark(e.originalEvent.balloon.getPosition()),e.originalEvent.balloon.close()})})})}return e.prototype.prepare_templates=function(){var e,t;return t="      <h4>$[properties.wikimapia_place.name]</h4>      <a href='$[properties.wikimapia_place.url]' target='wikimapia'>Открыть в викимапии</a>      <a style='display:block;margin-top: 15px;' href='#' class='btn btn-danger' onclick='return false;'>Поставить точку</a>    ",e="      <a id='set_placemark' href='#' class='btn btn-danger' onclick='return false;'>Поставить точку</a>    ",ymaps.layout.storage.add("my#wikimapia-balloon",ymaps.templateLayoutFactory.createClass(t)),ymaps.layout.storage.add("my#map-balloon",ymaps.templateLayoutFactory.createClass(e))},e.prototype.show_places=function(e,t,n){var r,i=this;return t==null&&(t=0),n==null&&(n=!1),r="/places.json?x1="+e[0][0]+"&y1="+e[0][1]+"&x2="+e[1][0]+"&y2="+e[1][1],t&&(r+="&outside=1"),$.getJSON(r,function(r){var s,o,u,a,f,l;a=r.results;for(f=0,l=a.length;f<l;f++)s=a[f],u={clusterCaption:s.name,balloonContentHeader:s.name,balloonContentBody:"Загрузка данных...",place:s},n||(n={iconImageHref:"/images/landmark-obelisk.png",iconImageSize:[32,60],iconImageOffset:[-15,-60]}),o=new ymaps.Placemark([s.lat,s.lng],u,n),o.events.add("click",function(e){var t,n;return n=e.get("target"),t=n.properties.get("place"),$.get("/places/"+t.id,function(e){return n.properties.set({balloonContentBody:e})})}),i.collection.add(o),i.clusterer.add(o);if(!t)return i.map.geoObjects.add(i.clusterer),i.show_places(e,1,n)})},e.prototype.set_placemark=function(e){var t=this;if(this.can==="edit")return this.placemark.geometry.setCoordinates(e),this.geodecode(e,function(n,r){return t.update_form(e,r)})},e.prototype.update_form=function(e,t){var n;return n=t.metaDataProperty.GeocoderMetaData,$("#"+ym_model+"_address").val(n.text),$("#"+ym_model+"_name").val(t.name),$("#"+ym_model+"_lat").val(e[0]),$("#"+ym_model+"_lng").val(e[1]),$("#"+ym_model+"_kind").val(n.kind),$("#"+ym_model+"_zoom").val(this.map.getZoom())},e.prototype.geocode=function(e,t){var n=this;return ymaps.geocode(e,{results:50}).then(function(e){return t(e.geoObjects)})},e.prototype.geodecode=function(e,t,n){var r,i=this;return $("[type=submit]").attr("disabled","disabled"),n==null&&(n=t,t=!1),r=ymaps.geocode(e,{results:1,kind:t?t:void 0}),r.then(function(t){var r,s,o,u;return o=t.geoObjects.get(0),s=o.properties.getAll(),r=s.metaDataProperty.GeocoderMetaData,r.kind==="area"||r.kind==="province"||r.kind==="country"||r.kind==="route"||r.kind==="hydro"?i.geodecode(e,"locality",n):(u=o.properties.get("name"),n(o.geometry.getCoordinates(),s),$("[type=submit]").removeAttr("disabled","false"))})},e.prototype.prepare_controls=function(){var e,t=this;return e="<h5>Поиск по координате с GPS</h5>    <u>Примеры:</u><br />\n    <strong>N 58 3.448  E 38 49.794</strong><br />    <strong>58°3.448 С  38°49.694 В</strong><br />    <i>* Вводить спецсимвол <strong>°</strong> - не обязательно    <p>Пожалуйста, соблюдайте формат!</p>    ",$("input.geocoded").wrap('<div class="input-append"></div>').after('<button class="btn decoded-search" type="button"><i class="icon-search"></i></button>').parent().after('<div style="display:none" class="geocode-results"><ul class="nav nav-list geocode-list"></ul><button class="btn" onclick="$(this).parent().hide().find(\'.geocode-list\').html(\'\');return false;">Закрыть</button></div>').after('<label data-placement="left" title="'+e+'" rel="tooltip" class="checkbox"><input id="search_by_gps" type="checkbox">Поиск по координатам с GPS</label>'),$("[rel=tooltip]").tooltip(),$("input#search").keydown(function(e){var t,n;(n=event.keyCode)||(n=event.which);if(n===13)return t=jQuery.Event("click"),t.currentTarget=$("button.btn.decoded-search",$(e.currentTarget).parent())[0],$("button.decoded-search").trigger("click",t),e.stopPropagation(),!1}),$("button.decoded-search").click(function(e){var n,r,i;return $("#search_by_gps").is(":checked")?ymaps.geocode($("input.geocoded").val()).then(function(e){var n;return n=e.geoObjects.get(0).geometry.getCoordinates(),t.set_placemark(n),t.map.setCenter(n)}):(r=$(e.currentTarget).parent(),n=r.parent().find(".geocode-results").show().find(".geocode-list"),n.html(""),i=r.find("input.geocoded").attr("value"),t.geocode(i,function(e){return e.each(function(e){var t;return t=$("<li><a href='#map'>"+e.properties.get("text")+"</a></li>"),t.find("a").get(0).geo_data=e,n.append(t)}),$(".geocode-list > li > a").click(function(e){var n;return n=$(e.currentTarget).get(0).geo_data,t.map.setCenter(n.geometry.getCoordinates()).setZoom(12)})}))})},e}(),window.PlaceMap=e}).call(this);