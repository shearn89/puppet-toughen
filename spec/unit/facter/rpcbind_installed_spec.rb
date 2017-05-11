describe 'rpcbind_installed', :type => :fact do
  before { Facter.clear }
  after { Facter.clear }

  context "on linux" do
    let (:facts) { {:kernel => 'Linux' } }
    it "should return true if installed" do
      Facter::Util::Resolution.stubs(:which).with('rpcbind').returns('/sbin/rpcbind')
      expect(Facter.fact(:rpcbind_installed).value).to eq(true)
    end

    it "should return false if not installed" do
      Facter::Util::Resolution.stubs(:which).with('rpcbind').returns(nil)
      expect(Facter.fact(:rpcbind_installed).value).to eq(false)
    end
  end

end
