describe 'privileged_commands', :type => :fact do
  before { Facter.clear }
  after { Facter.clear }

  context "linux" do
    let(:expected_bins) { ["/usr/fakebin"] }

    it "should return /usr/fakebin" do
      Facter::Util::Resolution.stubs(:exec).with("find / -xdev -type f -perm -4000 -o -type f -perm -2000 2>/dev/null").returns('/usr/fakebin')
      expect(Facter.fact(:privileged_commands).value).to eq(expected_bins)
    end
  end
end
