require 'rails_helper'

RSpec.describe Print, type: :model do
  subject(:print) { FactoryGirl.build(:print) }

  it 'should have a valid Factory' do
    expect(print).to be_valid
  end

  describe 'validations' do
    it 'should require a name' do
      print.name = nil
      expect(print).to_not be_valid
    end

    it 'should require a volume' do
      print.volume = nil
      expect(print).to_not be_valid
    end

    it 'should require a filament_id' do
      print.filament_id = nil
      expect(print).to_not be_valid
    end

    it 'should require a length' do
      print.length = nil
      expect(print).to_not be_valid
    end

    it 'should require a weight' do
      print.weight = nil
      expect(print).to_not be_valid
    end

    it 'should require a price' do
      print.price = nil
      expect(print).to_not be_valid
    end

    it 'should require a user_id' do
      print.user_id = nil
      expect(print).to_not be_valid
    end
    

    specify '#import' do
      class DummyFile
        def path
          File.new(File.join(Rails.root, 'spec', 'fixture_files', 'print_sample.csv'))
        end
      end

      FactoryGirl.create :filament
      user = FactoryGirl.create :user
      FactoryGirl.create :material

      expect do
        described_class.import(DummyFile.new, user.id)
      end.to change(Print, :count).by 1
    end
  end
end
