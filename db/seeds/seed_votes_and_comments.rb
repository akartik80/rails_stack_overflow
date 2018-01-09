module SeedVotesAndComments
  def self.seed
    votes = []
    comments = []

    User.all.each_with_index do |user, user_index|
      entities = %w[Question Answer]

      entities.each do |entity|
        entity.constantize.all.each_with_index do |dbvalue, index|
          votes << {
            votable: dbvalue,
            user: user,
            vote_type: (index.even? ? 1 : -1)
          }

          comments << {
            commentable: dbvalue,
            user: user,
            text: "Comment on #{entity} #{index + 1} by user #{user_index + 1}"
          }
        end
      end
    end

    Vote.create(votes)
    Comment.create(comments)
  end
end
