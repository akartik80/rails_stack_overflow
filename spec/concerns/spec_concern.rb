module SpecConcern
  extend ActiveSupport::Concern

  def json(json)
    JSON.parse(json, symbolize_names: true)
  end
end
