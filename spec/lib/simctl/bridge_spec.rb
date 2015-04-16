describe RunLoop::Simctl::Bridge do

  let (:abp) { Resources.shared.app_bundle_path }
  let (:sim_control) { RunLoop::SimControl.new }
  let (:device) {
    sim_control.simulators.shuffle.detect do |device|
      [device.state == 'Shutdown',
       device.name != 'rspec-0test-device',
       !device.name[/Resizable/,0]].all?
    end
  }

  let(:bridge) { RunLoop::Simctl::Bridge.new(device, abp) }

  describe '.new' do
    it 'populates its attributes' do
      expect(bridge.sim_control).to be_a_kind_of(RunLoop::SimControl)
      expect(bridge.app).to be_a_kind_of(RunLoop::App)
      expect(bridge.device).to be_a_kind_of(RunLoop::Device)
      path_to_sim_bundle = bridge.instance_variable_get(:@path_to_ios_sim_app_bundle)
      expect(Dir.exist?(path_to_sim_bundle)).to be_truthy
    end

    it 'quits the simulator' do
      expect(sim_control.sim_is_running?).to be_falsey
    end

    it 'the device is shutdown' do
      expect(bridge.update_device_state).to be == 'Shutdown'
    end

    it 'raises an error if App cannot be created from app bundle path' do
      allow_any_instance_of(RunLoop::App).to receive(:valid?).and_return(false)
      expect {
        RunLoop::Simctl::Bridge.new(device, abp)
      }.to raise_error
    end
  end

  describe '#simulator_app_dir' do
    it 'device version < 8.0' do
      expect(bridge.device).to receive(:version).and_return(RunLoop::Version.new('7.1'))
      path = bridge.simulator_app_dir
      expect(path[/Bundle/,0]).to be_falsey
    end

    it 'device version >= 8.0' do
      expect(bridge.device).to receive(:version).and_return(RunLoop::Version.new('8.0'))
      path = bridge.simulator_app_dir
      expect(path[/Bundle/,0]).to be_truthy
    end
  end

  describe '#update_device_state' do
    it 'raises error when no matching device can be found' do
      expect(bridge).to receive(:fetch_matching_device).and_return(nil)
      expect {
        bridge.update_device_state
      }.to raise_error(RuntimeError)
    end

    it 'returns valid device state' do
      expect(bridge).to receive(:fetch_matching_device).and_return(device)
      expect(device).to receive(:state).at_least(:once).and_return('Anything but nil or empty string')
      expect(bridge.update_device_state).to be == 'Anything but nil or empty string'

      # Unexpected.  Device#state is immutable, so we replace Simctl @device
      # when this method is called.
      expect(bridge.device).to be == device
    end
  end

  describe '#is_sdk_8?' do
    it 'returns true when sdk == 8.0' do
      expect(bridge.device).to receive(:version).and_return(RunLoop::Version.new('8.0'))
      expect(bridge.is_sdk_8?).to be_truthy
    end

    it 'returns true when sdk > 8.0' do
      expect(bridge.device).to receive(:version).and_return(RunLoop::Version.new('8.1'))
      expect(bridge.is_sdk_8?).to be_truthy
    end

    it 'returns false when sdk < 8.0' do
      expect(bridge.device).to receive(:version).and_return(RunLoop::Version.new('7.1'))
      expect(bridge.is_sdk_8?).to be_falsey
    end
  end

  it '#device_data_dir' do
    expect(Dir.exist?(bridge.device_data_dir)).to be_truthy
  end
end
