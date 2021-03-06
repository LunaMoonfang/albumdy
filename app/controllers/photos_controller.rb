class PhotosController < ResourceController::Base
  
  actions :index, :show
  
  index.wants.xml { render :xml => @collection }
  index.wants.rss  { render :layout => false } # uses index.rss.builder
  
  index.flash 'Photos'
  show.flash 'Photo'
  
  private #--------------

  # Explicitly defined for paging, to limit the visible photos, and to set the appropriate page title and description
  def collection
    @collection ||= end_of_association_chain.paginate :conditions => 'visible = 1', :page => params[:page], :per_page => 21, :order => 'created_at DESC'
    
    @page_title = 'Shared Photos'
    @page_description = "Click on a photo to see it's original resolution. Use the next and previous links to move through the list of photos."
    @feed_url = formatted_photos_url(:rss)
    
    return @collection
  end
  
end