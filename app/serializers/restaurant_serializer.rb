class RestaurantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :location, :url_link, :image_url, :slug

  has_many :reviews
  
end
