module SeedTags
  def self.seed
    tags = [
      {
        text: 'ruby'
      },

      {
        text: 'rails'
      },

      {
        text: 'node.js'
      }
    ]

    Tag.create(tags)
  end
end
