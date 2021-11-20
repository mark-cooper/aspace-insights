require 'spec_helper'

RSpec.describe Report, type: :model do
  it { is_expected.to have_db_column(:reportable_id).of_type(:integer) }
  it { is_expected.to have_db_column(:reportable_type).of_type(:string) }
  it { is_expected.to belong_to(:reportable) }
end
