describe 'rpcbind_installed', :type => :fact do
  before { Facter.clear }
  after { Facter.clear }

  context "linux" do
    let(:expected_val) { true }

    it "should return true" do
      Facter::Util::Resolution.stubs(:exec).with("rpm -qa | grep rpcbind").returns('rpcbind')
      expect(Facter.fact(:rpcbind_installed).value).to eq(expected_val)
    end
  end
end
