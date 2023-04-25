class ActivitiesSerializer 
  include JSONAPI::Serializer
  attributes :destination, :forecast, :activities
end