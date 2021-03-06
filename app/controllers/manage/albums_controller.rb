class Manage::AlbumsController < ApplicationController
  
  before_filter :login_required
  skip_before_filter :verify_authenticity_token
  
  def index
    @albums = current_user.albums.paginate :all, :page => params[:page], :per_page => 4, :order => 'created_at DESC'
    
    @page_title = "Manage Your Albums"
    @page_description = "From here you can create a new album and populate it with photos, or edit an exiting album."
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @albums }
    end
  end
  
  def show
    @album = current_user.albums.find(params[:id])
    
    @page_title = @album.title
    @page_description = @album.description
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @album }
    end
  end
  
  def new
    @album = current_user.albums.build
    
    @page_title = 'Create a New Photo Album'
    @page_description = 'Create a new album and populate it with photos.'
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @album }
    end
  end
  
  def edit
    @album = current_user.albums.find(params[:id])
    
    @page_title = @album.title
    @page_description = @album.description
  end
  
  def create
    @album = current_user.albums.build(params[:album])

    respond_to do |format|
      if @album.save
        flash[:notice] = 'Album successfully created.'
        format.html { redirect_to manage_album_path(@album) }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @album = current_user.albums.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        flash[:notice] = 'Album successfully updated.'
        format.html { redirect_to manage_album_path(@album) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @album = current_user.albums.find(params[:id])
    @album.destroy

    respond_to do |format|
      flash[:notice] = 'Album successfully removed.'
      format.html { redirect_to manage_albums_path }
      format.xml  { head :ok }
    end
  end
  
end
