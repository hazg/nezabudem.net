# encoding: utf-8
class SearchController < ApplicationController
  add_breadcrumb('Поиск', 'search')
  def results
    if params[:q]
      @results = Soldier.search(params[:q], :limit => 50)
    end
  end
end
