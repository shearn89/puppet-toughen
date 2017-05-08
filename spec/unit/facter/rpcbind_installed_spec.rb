describe 'rpcbind_installed', :type => :fact do
  before { Facter.clear }
  after { Facter.clear }

  context "redhat" do
    it "should return true if installed" do
      Facter::Util::Resolution.stubs(:exec).with("rpm -qa | grep rpcbind").returns('rpcbind')
      expect(Facter.fact(:rpcbind_installed).value).to eq(true)
    end

    it "should return false if not installed" do
      Facter::Util::Resolution.stubs(:exec).with("rpm -qa | grep rpcbind").returns('')
      expect(Facter.fact(:rpcbind_installed).value).to eq(false)
    end
  end
end
