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
    "#{Soldier.count} #{Russian.p(Soldier.count, 'оцифрованное имя', 'оцифрованных имени', 'оцифрованных имён')}"
  end
  
  def users_how_much
    "#{User.count} #{Russian.p(User.count, 'пользователь', 'пользователя', 'пользователей')}"
  end

  def comment_format text
    self.sanitize(text, :tags=>%W(p div ul li ol blockquote span strike b i pre h1 h2 h3 h4 table tr td th tbody), :attributes=>[])
  end
  def show_comments target
    render :partial => 'comments/tree', :locals => {:target => target}
  end

  def to_redactor( id )
    render :partial => 'application/redactor', :locals => {:id => id}
  end
  
  def user_link user
    link_to( user.nick, user.profile, :rel => user.id, :class => 'profile' )
  end

  def user_link_with_avatar user
    link_to(
      image_tag(user.avatar.photo.icon).html_safe+"<br />".html_safe+"#{user.nick}", 
      user.profile,
      :rel => user.id,
      :class => 'profile'
    )
  end

  
end
