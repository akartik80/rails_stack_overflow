describe User do
  let(:user) { FactoryBot.build(:user) }

  it 'has a valid factory' do
    expect(user.save).to eq true
  end

  context 'on deletion' do
    it 'is not found' do
      user.deleted_at = Time.now
      user.save
      expect { User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'on setting invalid attributes' do
    it 'is invalid without name' do
      user.name = nil
      expect(user.save).to eq false
    end

    it 'is invalid with name length > 50' do
      user.name = 'kartikarorakartikarorakartikarorakartikarorakartikarora'
      expect(user.save).to eq false
    end

    it 'is invalid without email' do
      user.email = nil
      expect(user.save).to eq false
    end

    it 'is invalid with email length > 50' do
      user.email = 'kartikarorakartikarorakartikarorakartikarorakartikar@ora'
      expect(user.save).to eq false
    end

    it 'is invalid with invalid email syntax' do
      user.email = 'email.domain.com'
      expect(user.save).to eq false
    end

    it 'is invalid if password does not match password confirmation' do
      user.password_confirmation = 'some random p@ssw0rd'
      expect(user.save).to eq false
    end
  end
end
