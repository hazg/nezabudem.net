#@encoding: utf-8
module ApplicationHelper

  def _( tag )
    I18n.t("tags.#{tag}")
    
  end

  def photos_need_ocr
    PlacePhoto.tagged_with I18n.t('tags.need_ocr')
  end

  
  def show_tag( t )
    render :partial => 'application/tag_thumb', :locals => {:t => t}
  end
  
  def places_how_much
    "#{Place.without_nodes.count} #{Russian.p(Place.without_nodes.count, 'объект', 'объекта', 'объектов')}"
  end

  def photos_how_much
    "#{PlacePhoto.count} #{Russian.p(PlacePhoto.count, 'фото', 'фотографии', 'фотографий')}"
  end

  def soldiers_how_much
    "#{Soldier.count} #{Russian.p(Soldier.count, 'оцифрованное имя', 'оцифрованных имён', 'оцифрованных имён')}"
  end
  
  def users_how_much
    "#{User.count} #{Russian.p(User.count, 'пользователь', 'пользователя', 'пользователей')}"
  end

end
