class PlaceMap
  
  constructor: (options) ->
    
    window.place_map = this
    @can = options['can'] if options['can'] != 'undefined'

    if ymaps? then ymaps.ready () =>
      @prepare_templates()
      @prepare_controls()
      
      center = [ymaps.geolocation.latitude, ymaps.geolocation.longitude]

      if options['center']
        center = options['center']
      else if window.ym_model and $("##{ym_model}_lat").val() > 0
        center = [$("##{window.ym_model}_lat").val(), $("##{window.ym_model}_lng").val()]
      zoom = 10
      zoom = options['zoom'] if options['zoom']

      # MAP CREATE
      @map = new ymaps.Map 'map',
        center: center
        zoom: zoom
        type: 'yandex#map'
        behaviors: ['default', 'scrollZoom']
      @map.options.set('balloonContentBodyLayout', 'my#map-balloon')
      @map.behaviors.get('dblClickZoom').disable()


      @collection = new ymaps.GeoObjectCollection()
      @clusterer = new ymaps.Clusterer()
      @clusterer.options.set
        gridSize: 32,
      

      if not options['show_all']
        @placemark = new ymaps.Placemark center, {},
          iconImageHref: '/images/landmark-obelisk.png'
          iconImageSize: [32, 60]
          iconImageOffset: [-15, -60]
        @map.geoObjects.add(@placemark)
        # Показываем существующие объекты для предотвращения дубликатов
        @show_places @map.getBounds(), 0, options =
          iconImageHref: '/images/landmark-obelisk-trans.png'
          iconImageSize: [15, 28]
          iconImageOffset: [-7, -14]
      else
        @show_places @map.getBounds(), 0

      # WIKIMAPIA INIT
      if options['show_wikimapia']
        collection_options =
          balloonContentBodyLayout: 'my#wikimapia-balloon'

        @wikimapia_collection = new ymaps.GeoObjectCollection(false, collection_options)
 

        @map.geoObjects.add(@wikimapia_collection)
        @show_wikimapia_objects @map.getBounds()
        @map.events.add 'boundschange', (e)=>
          @show_wikimapia_objects e.get('newBounds') if not @map.balloon.isOpen()


      # CONTROLS
      @map.controls
        .add('typeSelector')
        .add('zoomControl')
        .add('mapTools')

      # MAP EVENTS
      
      if @can == 'edit'
        @map.events.add 'click', (e) =>
          @balloon_pos = e.get("coordPosition")
          window.mcp = @balloon_pos
          @map.balloon.open( @balloon_pos )
        
      #window. = @map
      # MAP BALLOON EVENTS
      @map.balloon.events.add 'open', (e) =>
        
        $('#set_placemark').unbind('click').click (p) =>
      #    e.stopPropagation()
          #if window.for_members?
          #  window.for_members()
          #else
          @set_placemark( e.originalEvent.balloon.getPosition()  ) #@balloon_pos
          e.originalEvent.balloon.close()
          

  # PREPARE TEMPLATES
  prepare_templates: () =>

    # WIKIMAPIA BALLOON [ my#wikimapia-balloon ]
    wikimapia_balloon_template = "
      <h4>$[properties.wikimapia_place.name]</h4>
      <a href='$[properties.wikimapia_place.url]' target='wikimapia'>Открыть в викимапии</a>
      <a style='display:block;margin-top: 15px;' href='#' class='btn btn-danger' onclick='return false;'>Поставить точку</a>
    "
    # MAP DEFAULT BALLOON [ my#map-balloon ]
    map_balloon_template = "
      <a id='set_placemark' href='#' class='btn btn-danger' onclick='return false;'>Поставить точку</a>
    "
    ymaps.layout.storage.add('my#wikimapia-balloon', ymaps.templateLayoutFactory.createClass( wikimapia_balloon_template ))
    ymaps.layout.storage.add('my#map-balloon', ymaps.templateLayoutFactory.createClass( map_balloon_template ))

      
  #SHOW WIKIMAPIA OBJECTS
  #show_wikimapia_objects: (b) =>
    
  #  key = '2DD70717-AB5F7005-A526B076-6280D1B9-7AEC7ABB-4CEA0031-191DB647-B319EDDD'
  #  wiki = "http://api.wikimapia.org?key=#{key}&language=ru&format=json"
  #  uri_b = "#{wiki}&function=box&count=1000&bbox=#{b[0][1]},#{b[0][0]},#{b[1][1]},#{b[1][0]}"
  #  uri_o = "#{wiki}&function=object&id="
  #  $.getJSON uri_b, (d) =>
  #    @wikimapia_collection.removeAll()
      
  #    for o in d['folder'].reverse()
  #      geometry = [(o.polygon.map (xy) -> [xy.y, xy.x]), []]
  #      properties =
  #        hintContent: o['name']
  #        wikimapia_place: o
  #      options =
  #        interactivityModel: 'default#transparent'
  #        fill: true
  #        draggable: false
  #        strokeColor: '#ff0000'
  #        fillColor:   '#6699ff'
  #        strokeWidth: 1
  #        opacity: 0.2

  #      if /мемориал|могила|стелла|памятник|захороне|братск[аи]/i.test( o['name'] )
  #        options['opacity'] = 0.5
  #        options['strokeWidth'] = 3
  #        options['fillColor'] = '#990000'

  #      polygon = new ymaps.Polygon geometry, properties, options
         
        #polygon.events.add 'click', (e) =>
        #  @balloon_pos = e.get("coordPosition")
        #  e.stopPropagation()
  #      @wikimapia_collection.add(polygon)








































  # SHOW PLACES
  show_places: (b, outside = 0, options = false) =>
    url = "/places.json?x1=#{b[0][0]}&y1=#{b[0][1]}&x2=#{b[1][0]}&y2=#{b[1][1]}"
    url += '&outside=1' if outside
    $.getJSON url, (data) =>
      results = data['results']
      for o in results
        properties =
          clusterCaption: o['name']
          balloonContentHeader: o['name']
          balloonContentBody: 'Загрузка данных...'
          place: o
        if not options
          options =
            iconImageHref: '/images/landmark-obelisk.png'
            iconImageSize: [32, 60]
            iconImageOffset: [-15, -60]

          #hintContent: o['name'],

        placemark = new ymaps.Placemark [o['lat'], o['lng']], properties, options
         
        placemark.events.add 'click', (e) =>
          target = e.get('target')
          place = target.properties.get('place')
          $.get "/places/#{place['id']}", (data)=>
            target.properties.set({balloonContentBody:data})
          

        @collection.add(placemark)
        @clusterer.add(placemark)
      if not outside
        @map.geoObjects.add(@clusterer)
        @show_places(b, 1, options)
        
    #console.log "#{b[0][0]} #{b[0][1]} - #{b[1][0]} #{b[1][1]}"
  
  

  #SET PLACEMARK
  set_placemark: (pos) =>
    if @can == 'edit'
      @placemark.geometry.setCoordinates pos
      @geodecode pos, (point, meta) =>
        @update_form( pos, meta )




















  # UPDATE FORM
  update_form: (point, meta) =>
    #console.log(point)
    m = meta.metaDataProperty.GeocoderMetaData
    $("##{ym_model}_address").val(m['text'])
    $("##{ym_model}_name").val(meta['name'])
    $("##{ym_model}_lat").val(point[0])
    $("##{ym_model}_lng").val(point[1])
    $("##{ym_model}_kind").val(m['kind'])
    $("##{ym_model}_zoom").val(@map.getZoom())

  #GEOCODE
  geocode: (text, fn) ->
    ymaps.geocode(text, {results:50}).then (objects) =>
      fn(objects.geoObjects)

  #GEODECODE
  geodecode: (point, kind , fn) ->
    $('[type=submit]').attr('disabled', 'disabled')
    if not fn?
      fn = kind
      kind = false
    geodecoder = ymaps.geocode point,
      results: 1
      kind: kind if kind

    geodecoder.then (objects) =>
      o = objects.geoObjects.get(0)
      meta = o.properties.getAll()
      m = meta.metaDataProperty.GeocoderMetaData
      if m.kind == 'area' or m.kind == 'province' or m.kind == 'country' or m.kind == 'route' or m.kind == 'hydro'
        @geodecode point, 'locality', fn
      else
        res = o.properties.get('name')
        fn(o.geometry.getCoordinates(), meta)
        $('[type=submit]').removeAttr('disabled', 'false')

  # PREPARE CONTROLS
  prepare_controls: () =>
    search_by_coords =
    '<h5>Поиск по координате с GPS</h5>
    <u>Примеры:</u><br />\n
    <strong>N 58 3.448  E 38 49.794</strong><br />
    <strong>58°3.448 С  38°49.694 В</strong><br />
    <i>* Вводить спецсимвол <strong>°</strong> - не обязательно
    <p>Пожалуйста, соблюдайте формат!</p>
    '
    $('input.geocoded')
      .wrap('<div class="input-append"></div>')
      .after('<button class="btn decoded-search" type="button"><i class="icon-search"></i></button>').parent()
      .after('<div style="display:none" class="geocode-results"><ul class="nav nav-list geocode-list"></ul><button class="btn" onclick="$(this).parent().hide().find(\'.geocode-list\').html(\'\');return false;">Закрыть</button></div>')
      .after('<label data-placement="left" title="'+search_by_coords+'" rel="tooltip" class="checkbox"><input id="search_by_gps" type="checkbox">Поиск по координатам с GPS</label>')
    $('[rel=tooltip]').tooltip()
#   
    $('input#search').keydown (e) =>
      keycode = event.which if not keycode = event.keyCode
      if keycode == 13
        ev = jQuery.Event("click")
        ev.currentTarget = $('button.btn.decoded-search', $(e.currentTarget).parent())[0]
        $('button.decoded-search').trigger('click', ev)
        e.stopPropagation()
        false
      
    $('button.decoded-search').click (e) =>
      if $('#search_by_gps').is(':checked')
        #SEARCH BY COORDS
        ymaps.geocode($('input.geocoded').val()).then (p) =>
          #@set_placemark([coords[1], coords[0]])
          coords = p.geoObjects.get(0).geometry.getCoordinates()
          @set_placemark(coords)
          @map.setCenter(coords)
        #$.ajax
        #  dataType: 'json',
        #  data: "q=#{$('input.geocoded').val()}",
        #  url: "/google_geo.json",
        #  success: (d) =>
        #    window.d = d
        #    coords = d.Placemark[0].Point.coordinates
        #    @set_placemark([coords[1], coords[0]])
            
      else
        #SEARCH BY ADDRESS
        parent = $(e.currentTarget).parent()
        list = parent.parent().find('.geocode-results').show().find('.geocode-list')
        list.html('')
        text = parent.find('input.geocoded').attr('value')
        @geocode text, (t) =>
          t.each (o) =>
            a = $("<li><a href='#map'>#{o.properties.get('text')}</a></li>")
            a.find('a').get(0).geo_data = o
            list.append(a)
          $('.geocode-list > li > a').click (e) =>
            data = $(e.currentTarget).get(0).geo_data
            @map.setCenter(data.geometry.getCoordinates()).setZoom(12)
      

window.PlaceMap = PlaceMap

