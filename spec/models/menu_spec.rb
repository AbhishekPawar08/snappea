require 'rails_helper'

RSpec.describe Menu, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  subject { described_class.new}
  it { should belong_to (:restaurant)}
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description)}
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:restaurant_id)}
end
