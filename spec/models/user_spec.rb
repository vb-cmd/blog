require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user) }

    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a first name' do
      user.firstname = nil
      user.valid?
      expect(user.errors[:firstname]).to include("can't be blank")
    end

    it 'is not valid without a last name' do
      user.lastname = nil
      user.valid?
      expect(user.errors[:lastname]).to include("can't be blank")
    end

    it 'is not valid without an email' do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is not valid with a duplicate email' do
      created_user = create(:user)
      user.email = created_user.email
      user.valid?
      expect(user.errors[:email]).to include('has already been taken')
    end

    it 'is not valid without a password' do
      user.password = nil
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'is not valid without a password confirmation' do
      user.password = 'password'
      user.password_confirmation = nil
      user.valid?
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'is not valid with mismatched passwords' do
      user.password = 'password'
      user.password_confirmation = 'wrong'
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'is not valid without a birth date' do
      user.birth_date = nil
      user.valid?
      expect(user.errors[:birth_date]).to include("can't be blank")
    end

    it 'is not valid with a birth date in the future' do
      user.birth_date = nil
      user.valid?
      expect(user.errors[:birth_date]).to include("can't be blank")
    end
  end

  describe 'instance method' do
    let(:user) { create(:user) }

    describe '#full_name' do
      let(:user_full_name) { "#{user.firstname} #{user.lastname}" }

      it 'returns the full name' do
        expect(user.full_name).to eq user_full_name
      end
    end

    describe '#age' do
      let(:calculated_user_age) { (Date.today - user.birth_date).to_i / 365 }

      it 'returns the ' do
        expect(user.age).to eq(calculated_user_age)
      end
    end
  end
end
