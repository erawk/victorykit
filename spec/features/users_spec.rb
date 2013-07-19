describe 'a user' do

  context 'visiting the home page' do
    before { visit '/' }
    
    subject { page }
    
    it { should have_content 'Win your campaign for change' }
    it { should have_link 'Start a Petition' }
  end

  context 'joining the site' do
    let(:email) { 'user@test.com' }
    let(:pass)  { 'pass' }

    it 'should successfuly sign in' do
      signin email, pass do
        page.current_path.should eq '/'
        page.should have_link 'Log Out'
      end  
    end
  end

  context 'already registered' do
    let(:user) { create :user }
    
    it 'should successfuly login' do
      login user.email, user.password do
        page.current_path.should eq '/'
        page.should have_link 'Log Out'
       end 
    end
  end

  context 'visiting the privacy policy page' do
    before { visit '/privacy' }
    
    subject { page }

    it { should have_content 'Privacy Policy' }
    it { should have_content "We don't share your email address without your permission." }
  end

end