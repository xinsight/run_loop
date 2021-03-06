describe RunLoop::Environment do

  let(:environment) { RunLoop::Environment.new }

  describe ".user_home_directory" do
    it "always returns a directory that exists" do
      expect(File.exist?(RunLoop::Environment.user_home_directory)).to be_truthy
    end

    it "returns local ./tmp/home on the XTC" do
      expect(RunLoop::Environment).to receive(:xtc?).and_return true

      expected = File.join("./", "tmp", "home")
      expect(RunLoop::Environment.user_home_directory).to be == expected
      expect(File.exist?(expected)).to be_truthy
    end
  end

  describe '.debug?' do
    it "returns true when DEBUG == '1'" do
      stub_env('DEBUG', '1')
      expect(RunLoop::Environment.debug?).to be == true
    end

    it "returns false when DEBUG != '1'" do
      stub_env('DEBUG', 1)
      expect(RunLoop::Environment.debug?).to be == false
    end
  end

  describe '.debug_read?' do
    it "returns true when DEBUG_READ == '1'" do
      stub_env('DEBUG_READ', '1')
      expect(RunLoop::Environment.debug_read?).to be == true
    end

    it "returns false when DEBUG_READ != '1'" do
      stub_env('DEBUG_READ', 1)
      expect(RunLoop::Environment.debug_read?).to be == false
    end
  end

  describe '.xtc?' do
    it "returns true when XAMARIN_TEST_CLOUD == '1'" do
      stub_env('XAMARIN_TEST_CLOUD', '1')
      expect(RunLoop::Environment.xtc?).to be == true
    end

    it "returns false when XAMARIN_TEST_CLOUD != '1'" do
      stub_env('XAMARIN_TEST_CLOUD', 1)
      expect(RunLoop::Environment.xtc?).to be == false
    end
  end

  it '.trace_template' do
    stub_env('TRACE_TEMPLATE', '/my/tracetemplate')
    expect(RunLoop::Environment.trace_template).to be == '/my/tracetemplate'
  end

  describe '.uia_timeout' do
    it 'returns the value of UIA_TIMEOUT' do
      stub_env('UIA_TIMEOUT', 10.0)
      expect(RunLoop::Environment.uia_timeout).to be == 10.0
    end

    it 'converts non-floats to floats' do
      stub_env('UIA_TIMEOUT', '10.0')
      expect(RunLoop::Environment.uia_timeout).to be == 10.0

      stub_env('UIA_TIMEOUT', 10)
      expect(RunLoop::Environment.uia_timeout).to be == 10.0
    end
  end

  describe '.bundle_id' do
    it 'correctly returns bundle id env var' do
      stub_env('BUNDLE_ID', 'com.example.Foo')
      expect(RunLoop::Environment.bundle_id).to be == 'com.example.Foo'
    end

    it 'returns nil when bundle id is the empty string' do
      stub_env('BUNDLE_ID', '')
      expect(RunLoop::Environment.bundle_id).to be == nil
    end
  end

  describe '.path_to_app_bundle' do
    let (:abp) { '/my/app/bundle/path.app' }
    describe 'only one is defined' do
      it 'APP_BUNDLE_PATH' do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with('APP_BUNDLE_PATH').and_return(abp)
        allow(ENV).to receive(:[]).with('APP').and_return(nil)
        expect(RunLoop::Environment.path_to_app_bundle).to be == abp
      end

      it 'APP' do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with('APP_BUNDLE_PATH').and_return(nil)
        allow(ENV).to receive(:[]).with('APP').and_return(abp)
        expect(RunLoop::Environment.path_to_app_bundle).to be == abp
      end
    end

    it 'when both APP_BUNDLE_PATH and APP are defined, the first takes precedence' do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('APP_BUNDLE_PATH').and_return(abp)
      allow(ENV).to receive(:[]).with('APP').and_return('/some/other/path.app')
      expect(RunLoop::Environment.path_to_app_bundle).to be == abp
    end

    describe 'empty strings should be interpreted as nil' do
      it 'APP_BUNDLE_PATH' do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with('APP_BUNDLE_PATH').and_return('')
        allow(ENV).to receive(:[]).with('APP').and_return(nil)
        expect(RunLoop::Environment.path_to_app_bundle).to be == nil
      end

      it 'APP' do
        expect(RunLoop::Environment.path_to_app_bundle).to be == nil
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with('APP_BUNDLE_PATH').and_return(nil)
        allow(ENV).to receive(:[]).with('APP').and_return('')
      end

      it 'both' do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with('APP_BUNDLE_PATH').and_return('')
        allow(ENV).to receive(:[]).with('APP').and_return('')
        expect(RunLoop::Environment.path_to_app_bundle).to be == nil
      end
    end

    it "expands relative paths" do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('APP_BUNDLE_PATH').and_return("./CalSmoke-cal.app")

      dirname = File.dirname(__FILE__)
      expected = File.expand_path(File.join(dirname, '..', '..', "CalSmoke-cal.app"))
      expect(RunLoop::Environment.path_to_app_bundle).to be == expected
    end
  end

  describe '.developer_dir' do
    it 'return value' do
      stub_env('DEVELOPER_DIR', '/some/xcode/path')
      expect(RunLoop::Environment.developer_dir).to be == '/some/xcode/path'
    end

    it 'returns nil if value is the empty string' do
      stub_env('DEVELOPER_DIR', '')
      expect(RunLoop::Environment.developer_dir).to be == nil
    end
  end

  describe '.sim_post_launch_wait' do
    it 'returns float value' do
      stub_env('CAL_SIM_POST_LAUNCH_WAIT', '1.0')
      expect(RunLoop::Environment.sim_post_launch_wait).to be == 1.0

      stub_env('CAL_SIM_POST_LAUNCH_WAIT', 1.0)
      expect(RunLoop::Environment.sim_post_launch_wait).to be == 1.0

      stub_env('CAL_SIM_POST_LAUNCH_WAIT', '1')
      expect(RunLoop::Environment.sim_post_launch_wait).to be == 1.0
    end

    it 'returns nil if the value cannot be converted to non-zero float' do
      stub_env('CAL_SIM_POST_LAUNCH_WAIT', '')
      expect(RunLoop::Environment.sim_post_launch_wait).to be == nil

      stub_env({'CAL_SIM_POST_LAUNCH_WAIT' => nil})
      expect(RunLoop::Environment.sim_post_launch_wait).to be == nil

      stub_env('CAL_SIM_POST_LAUNCH_WAIT', true)
      expect(RunLoop::Environment.sim_post_launch_wait).to be == nil
    end
  end
end

