require "./lib/Airport.rb"


describe Airport do

	it { is_expected.to respond_to(:land).with(1).argument }

	it { is_expected.to respond_to(:take_off) }

	it "return can not land, airport is full!" do
		allow(subject.weather).to receive(:stormy?).and_return false
		plane = Plane.new
		allow(plane).to receive(:landed).and_return false
		subject.capacity.times { subject.land(plane) }
		expect { subject.land(plane) }.to raise_error "Can not land, airport is full!"
	end

	it "return Can not take off, weather is too bad" do
		allow(subject.weather).to receive(:stormy?).and_return true
		plane = Plane.new
		expect { subject.take_off(plane) }.to raise_error "Can not take off, weather is too bad."
	end

	it "return Can not land, weather is too bad" do
		allow(subject.weather).to receive(:stormy?).and_return true
		plane = Plane.new
		expect { subject.land(plane) }.to raise_error "Can not land, weather is too bad."
	end

	it "will only allow planes to take off from the airport that they are at" do
		allow(subject.weather).to receive(:stormy?).and_return false
		plane = Plane.new
		expect { subject.take_off(plane) }.to raise_error "Can not take off, plane is not at this airport."
	end

	it "can set own airport capacity" do
		allow(subject.weather).to receive(:stormy?).and_return false
		airport = Airport.new(30)
		plane = Plane.new
		allow(plane).to receive(:landed).and_return false
		subject.capacity.times { subject.land(plane) }
		expect { subject.land(plane) }.to raise_error "Can not land, airport is full!"
	end

end