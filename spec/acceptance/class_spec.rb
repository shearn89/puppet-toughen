require 'spec_helper_acceptance'

describe 'toughen' do
  let(:manifest) {
    <<-EOS
      include ::toughen
    EOS
  }

  it 'should run without errors' do
    result = apply_manifest(manifest, :catch_failures => true)
    expect(@result.exit_code).to eq 2
  end

  it 'should run a second time without changes' do
    result = apply_manifest(manifest, :catch_failures => true)
    expect(@result.exit_code).to eq 0
  end

end
