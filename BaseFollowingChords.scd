(

s.boot;

/*******************************************************************************************
*   Start Markov Model
*******************************************************************************************/

~chordBaseTemplate = (
	name: "",
	numTransitions: 0,
	followingChords: Array.new,
	probabilities: Array.new,
	addFollowingChord: {|self, entry|
		var containsIndex = -1;
		self.numTransitions = self.numTransitions + 1;
		//iterate over array to see if entry is already there
		//save index if so
		self.followingChords.do{|item, index|
			if(item.key == entry) {containsIndex = index};
		};
		//if not there add new Entry with occurrence of 1
		if(containsIndex == -1)
		{
			self.followingChords = self.followingChords.add(entry -> 1);
		}
		//else increment occurrences by 1
		{
			var occ = self.followingChords.at(containsIndex).value;
			self.followingChords.put(containsIndex, entry -> (occ+1));
		};
		self.calcProbabilities;
	},
	calcProbabilities:{|self|
		self.probabilities = Array.newClear(self.followingChords.size);
		self.followingChords.do{|item, index|
			self.probabilities.put(index, item.key -> (item.value/self.numTransitions));
		}
	},
	print: {|self|
				(self.name + ":").postln;
		"".postln;
		self.followingChords.postln;
		self.probabilities.postln;
		"".postln;
	}
);

/***********************************
*   Start Chord Input
***********************************/

~chordList = ["Cm","D#","F","D#","Gm","Bb","A#sus4","A7sus4","Gm","Bb","A#sus4","A7sus4","Gm","Bb","A#sus4","A7sus4","Cm","D#","F","D#","Gm","Bb","A#sus4","A7sus4","Gm","Bb","A#sus4","A7sus4","Cm","D#","F","D#","Gm","Bb","A#sus4","A7sus4","Gm","Bb","A#sus4","A7sus4","Gm","Dm*","E","Gm","Gm","Dm*","E","Gm","Dm*","E","Gm","Gm","Dm*","E","Am","G#","C","D","Am","G#","C", "D"];

~bbMajPentBase = [66, 70, 72, 74, 77, 79];
~bbMajPent = Array.new();
(0..6).do{|i|
	~bbMajPent = ~bbMajPent.addAll(~bbMajPentBase.scramble);
}



/***********************************
*   End Chord Input
***********************************/


/***********************************
*   Start Chord Midi Mapping
***********************************/

~midiMapping = (
	\name: "",
	\bassNote: 0,
	\otherNotes: Array.new,

);

~midiMappings = (
	entries: Array.new,
	getAvailableBassnotes: {|self|
		var bnl = Array.new;
		self.entries.do{|n,i|
			bnl = bnl.add(n.bassNote);
		};
		//add twice so that the note is picked twice.
		bnl = bnl.stutter(2);
	},
	findEntry: {|self, chord|
		var occurrences = -1;
		self.entries.do{|n,i|
			if(n.name == chord) {occurrences = i};
		};
		self.entries.at(occurrences);
	}
);

~cm = ~midiMapping.deepCopy;
~cm.name = "Cm";
~cm.bassNote = 24;
~cm.otherNotes = ~cm.otherNotes.add(60);
~cm.otherNotes = ~cm.otherNotes.add(63);
~cm.otherNotes = ~cm.otherNotes.add(67);
~midiMappings.entries = ~midiMappings.entries.add(~cm);


~dsharp = ~midiMapping.deepCopy;
~dsharp.name = "D#";
~dsharp.bassNote = 27;
~dsharp.otherNotes = ~dsharp.otherNotes.add(63);
~dsharp.otherNotes = ~dsharp.otherNotes.add(67);
~dsharp.otherNotes = ~dsharp.otherNotes.add(70);
~midiMappings.entries = ~midiMappings.entries.add(~dsharp);

~f = ~midiMapping.deepCopy;
~f.name = "F";
~f.bassNote = 29;
~f.otherNotes = ~f.otherNotes.add(60);
~f.otherNotes = ~f.otherNotes.add(65);
~f.otherNotes = ~f.otherNotes.add(69);
~midiMappings.entries = ~midiMappings.entries.add(~f);

~gm = ~midiMapping.deepCopy;
~gm.name = "Gm";
~gm.bassNote = 31;
~gm.otherNotes = ~gm.otherNotes.add(61);
~gm.otherNotes = ~gm.otherNotes.add(67);
~gm.otherNotes = ~gm.otherNotes.add(71);
~midiMappings.entries = ~midiMappings.entries.add(~gm);

~dmstar = ~midiMapping.deepCopy;
~dmstar.name = "Dm*";
~dmstar.bassNote = 26;
~dmstar.otherNotes = ~dmstar.otherNotes.add(64);
~dmstar.otherNotes = ~dmstar.otherNotes.add(65);
~dmstar.otherNotes = ~dmstar.otherNotes.add(69);
~midiMappings.entries = ~midiMappings.entries.add(~dmstar);

~e = ~midiMapping.deepCopy;
~e.name = "E";
~e.bassNote = 28;
~e.otherNotes = ~e.otherNotes.add(64);
~e.otherNotes = ~e.otherNotes.add(68);
~e.otherNotes = ~e.otherNotes.add(71);
~midiMappings.entries = ~midiMappings.entries.add(~e);

~bb = ~midiMapping.deepCopy;
~bb.name = "Bb";
~bb.bassNote = 34;
~bb.otherNotes = ~bb.otherNotes.add(58);
~bb.otherNotes = ~bb.otherNotes.add(62);
~bb.otherNotes = ~bb.otherNotes.add(65);
~midiMappings.entries = ~midiMappings.entries.add(~bb);

~asharpsus4 = ~midiMapping.deepCopy;
~asharpsus4.name = "A#sus4";
~asharpsus4.bassNote = 34;
~asharpsus4.otherNotes = ~asharpsus4.otherNotes.add(50);
~asharpsus4.otherNotes = ~asharpsus4.otherNotes.add(52);
~asharpsus4.otherNotes = ~asharpsus4.otherNotes.add(58);
~midiMappings.entries = ~midiMappings.entries.add(~asharpsus4);

~a7sus4 = ~midiMapping.deepCopy;
~a7sus4.name = "A7sus4";
~a7sus4.bassNote = 31;
~a7sus4.otherNotes = ~a7sus4.otherNotes.add(57);
~a7sus4.otherNotes = ~a7sus4.otherNotes.add(62);
~a7sus4.otherNotes = ~a7sus4.otherNotes.add(64);
~midiMappings.entries = ~midiMappings.entries.add(~a7sus4);


~am = ~midiMapping.deepCopy;
~am.name = "Am";
~am.bassNote = 33;
~am.otherNotes = ~a7sus4.otherNotes.add(57);
~am.otherNotes = ~a7sus4.otherNotes.add(60);
~am.otherNotes = ~a7sus4.otherNotes.add(64);
~midiMappings.entries = ~midiMappings.entries.add(~am);


~c = ~midiMapping.deepCopy;
~c.name = "C";
~c.bassNote = 24;
~c.otherNotes = ~c.otherNotes.add(55);
~c.otherNotes = ~c.otherNotes.add(60);
~c.otherNotes = ~c.otherNotes.add(64);
~midiMappings.entries = ~midiMappings.entries.add(~c);


~d = ~midiMapping.deepCopy;
~d.name = "D";
~d.bassNote = 26;
~d.otherNotes = ~d.otherNotes.add(59);
~d.otherNotes = ~d.otherNotes.add(62);
~d.otherNotes = ~d.otherNotes.add(66);
~midiMappings.entries = ~midiMappings.entries.add(~d);


~gsharp = ~midiMapping.deepCopy;
~gsharp.name = "G#";
~gsharp.bassNote = 32;
~gsharp.otherNotes = ~gsharp.otherNotes.add(56);
~gsharp.otherNotes = ~gsharp.otherNotes.add(60);
~gsharp.otherNotes = ~gsharp.otherNotes.add(63);
~midiMappings.entries = ~midiMappings.entries.add(~gsharp);


/***********************************
*   End Chord Midi Mapping
***********************************/


~ch = ~midiMappings.getChords(~chordList);
~bassNotes = Array.new();
~highNotes1 = Array.new();
~highNotes2 = Array.new();
~highNotes3 = Array.new();

~chordList.do{|n,i|
	var bn = ~midiMappings.findEntry(n);
	~bassNotes = ~bassNotes.add(bn.bassNote);
	~highNotes1 = ~highNotes1.add(bn.otherNotes.at(0));
	~highNotes2 = ~highNotes2.add(bn.otherNotes.at(1));
	~highNotes3 = ~highNotes3.add(bn.otherNotes.at(2));
};


~chords = (
	list: Array.new,
	find:{|self, entry|
		var index = -1;
		self.list.do{|n, i|
			if(entry == n.name){index = i;};
		};
		self.list.at(index);
	}
);
for(0, (~chordList.size - 1), {|i|
	var o = -1;
	~chords.list.do{|n, j|
		if(n.name == ~chordList.at(i)){o = j;}
	};
	if(o != -1){
		//update if chord already exists in list.
		if(~chordList.at(i+1).isNil == false){
			//check for last chord and avoid index overflow
			~chords.list.at(o).addFollowingChord(~chordList.at(i+1));
		}
	}
	{
		//add to list if chord doesn't exist
		var tmp = ~chordBaseTemplate.deepCopy;
		tmp.name = ~chordList.at(i);
		if(~chordList.at(i+1).isNil == false){
			//check for last chord and avoid index overflow
			tmp.addFollowingChord(~chordList.at(i+1));
		};
		~chords.list = ~chords.list.add(tmp);
	}
});

//init with first entry
~test = ~chords.find(~chordList.at(0));
~test.name.postln;
(0..40).do{
	var names = Array.new;
	var probabilities = Array.new;
	var ch;
	~test.probabilities.do{|n, i|
		names = names.add(n.key);
		probabilities = probabilities.add(n.value);
	};
	ch = names.wchoose(probabilities);
	ch.postln;
	~test = ~chords.find(ch);
};


/*******************************************************************************************
*   End Markov Model
*******************************************************************************************/


/*******************************************************************************************
*   Start SynthDefs
*******************************************************************************************/

/***********************************
*   Start Drums
*   Source: http://sccode.org/1-54H
***********************************/


SynthDef(\hihat, {arg out = 0, amp = 0.5, att = 0.01, rel = 0.2, ffreq = 6000, pan = 0;
	var env, snd;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd = WhiteNoise.ar;
	snd = HPF.ar(in: snd, freq: ffreq, mul: env);
	Out.ar(out, Pan2.ar(snd, pan));
}).add;

SynthDef(\snare, {arg out = 0, amp = 0.1, sinfreq = 180, att = 0.01, rel = 0.2, ffreq = 2000, pan = 0;
	var env, snd1, snd2, sum;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd1 = HPF.ar(
		in: WhiteNoise.ar,
		freq: ffreq,
		mul: env
	);
	snd2 = SinOsc.ar(freq: sinfreq, mul: env);
	sum = snd1 + snd2;
	Out.ar(out, Pan2.ar(sum, pan));
}).add;

SynthDef(\kick, {arg out = 0, amp = 0.3, sinfreq = 60, glissf = 0.9, att = 0.01, rel = 0.45, pan = 0;
	var env, snd, ramp;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	ramp = XLine.kr(
		start: sinfreq,
		end: sinfreq * glissf,
		dur: rel
	);
	snd = SinOsc.ar(freq: ramp, mul: env);
	snd = Pan2.ar(snd, pan);
	Out.ar(out, snd);
}).add;

/***********************************
*   End Drums
***********************************/


/***********************************
*   Start Bass
*   Source: https://github.com/geoffroymontel/supercollider-experiments/blob/master/example%20patterns.scd
***********************************/


SynthDef(\bass, { |freq = 440, gate = 1, amp = 0.5, slideTime = 0.17, ffreq = 1100, width = 0.15,
        detune = 1.005, preamp = 4|
    var    sig,
        env = Env.adsr(0.01, 0.3, 0.4, 0.1);
    freq = Lag.kr(freq, slideTime);
    sig = Mix(VarSaw.ar([freq, freq * detune], 0, width, preamp)).distort * amp
        * EnvGen.kr(env, gate, doneAction: 2);
    sig = LPF.ar(sig, ffreq);
    Out.ar(0, sig ! 2)
}).add;


/***********************************
*   End Bass
***********************************/



/*******************************************************************************************
*   Start Playback
*******************************************************************************************/

(
Pbind(
	\instrument, \hihat,
	\dur, Pseq([1], 40),
	\att, 0.01,
	\rel, 0.1,
	\ffreq, 11000,
	\pan, 0,
	\amp, 0.7
).play;

Pbind(
	\instrument, \kick,
	\dur, Pseq([1, 2], 20),
	\att, 0.01,
	\rel, 0.22,
	\sinfreq, 60,
	\glissf, 0.9,
	\amp, 1,
).play;

Pbind(
	\instrument, \snare,
	\dur, Pseq([Rest(2), 2, 3], 14),
	\att, 0.01,
	\rel, 0.1,
	\sinfreq, 180,
	\ffreq, 2000,
	\amp, 0.25

).play;

Pbind(
    \instrument, \bass,
	\midinote, Pseq(~bassNotes, 1),
    \dur, 2,
    \legato, Pseq([0.9, 0.9], 20),
    \amp, 0.3, \detune, 1.005
).play;


Pbind(
    \instrument, \bass,
	\midinote, Pseq(~highNotes1, 1),
    \dur, 2,
    \amp, 0.5
).play;

Pbind(
    \instrument, \bass,
	\midinote, Pseq(~highNotes2, 1),
    \dur, 2,
    \amp, 0.3
).play;

Pbind(
    \instrument, \bass,
	\midinote, Pseq(~highNotes3, 1),
    \dur, 2,
    \amp, 0.3
).play;

Pbind(
    \instrument, \default,
	\midinote, Pseq([Rest(2), Rest(4)]++(~bbMajPent.scramble), 6),
    \dur, 1,
    \amp, 0.6
).play;

)

/*******************************************************************************************
*   End Playback
*******************************************************************************************/

)