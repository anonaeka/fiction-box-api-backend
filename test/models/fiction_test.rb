# == Schema Information
#
# Table name: fictions
#
#  id          :bigint           not null, primary key
#  article     :text
#  description :text
#  image_url   :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_fictions_on_category_id  (category_id)
#  index_fictions_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class FictionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
