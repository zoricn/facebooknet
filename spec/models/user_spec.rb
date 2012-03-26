require 'spec_helper'

describe User do

  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:encrypted_password).of_type(:string) }
  it { should have_db_column(:reset_password_token).of_type(:string) }
  it { should have_db_column(:remember_created_at).of_type(:datetime) }
  it { should have_db_column(:sign_in_count).of_type(:integer) }
  it { should have_db_column(:current_sign_in_at).of_type(:datetime) }
  it { should have_db_column(:last_sign_in_at).of_type(:datetime) }
  it { should have_db_column(:current_sign_in_ip).of_type(:string) }
  it { should have_db_column(:last_sign_in_ip).of_type(:string) }

  it { should have_and_belong_to_many(:roles) }

  let(:user) { Factory(:user) }

  let(:admin_role) { Factory(:role, :name => "admin") }
  let(:regular_role) { Factory(:role, :name => "regular") }

  describe ".role?" do

    context "user has asked role" do

      before do
        user.roles.clear
        user.roles << regular_role
      end

      it "returns true" do
        user.role?(regular_role.name).should be_true
      end

    end

    context "user doesn't have asked role" do

      before do
        user.roles.clear
        user.roles << regular_role
      end

      it "returns false" do
        user.role?(admin_role.name).should be_false
      end

    end

  end

  describe ".make_regular" do

    before do
      Role.find_or_create_by_name("regular")
      user.make_regular
    end

    it "adds regular role to user" do
      user.should be_regular
    end

  end

  describe ".revoke_regular" do

    before do
      Role.find_or_create_by_name("regular")
      user.make_regular
      user.revoke_regular
    end

    it "removes regular role from user" do
      user.should_not be_regular
    end

  end

  describe ".regular?" do

    before do
      user.roles.clear
    end

    it "returns true if user is regular" do
      user.roles << regular_role
      user.regular?.should be_true
    end

    it "returns false is user is not regular" do
      user.roles << admin_role
      user.regular?.should be_false
    end

  end

end
