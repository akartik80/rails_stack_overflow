module SeedRevisions
  def self.seed
    revisions = []

    Questions.all.each do |question|
      revisions << {
        revisionable: question,
        metadata: { a: 'b' }.to_json
      }
    end
  end
end
