# == Schema Information
#
# Table name: reviews
#
#  id          :bigint           not null, primary key
#  description :text
#  score       :decimal(, )
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  fiction_id  :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_reviews_on_fiction_id  (fiction_id)
#  index_reviews_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (fiction_id => fictions.id)
#  fk_rails_...  (user_id => users.id)
#
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :fiction
  
  validates :score, presence: true
end
