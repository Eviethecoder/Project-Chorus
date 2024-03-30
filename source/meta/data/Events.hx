package meta.data;

import meta.data.ScriptHandler;
import meta.state.PlayState;
import openfl.utils.Assets;

using StringTools;

typedef PlacedEvent =
{
	var timestamp:Float;
	var params:Array<Dynamic>;
	var eventName:String;
};

class Events
{
	public static var loadedModules:Map<String, ForeverModule> = [];
	public static var eventList:Array<String> = [];

	public static function obtainEvents()
	{
		loadedModules.clear();
		eventList = [];

		var futureEvents:Array<String> = [];
		var futureSubEvents:Array<String> = [];

		for (event in Assets.list().filter(list -> list.contains('assets/events')))
		{
			var daEvent:String = event.replace('assets/events/', '');

			if (daEvent.contains('/'))
				daEvent = daEvent.replace(daEvent.substring(daEvent.indexOf('/'), daEvent.length), ''); // fancy

			if (daEvent.contains('.'))
			{
				daEvent = daEvent.substring(0, daEvent.indexOf('.', 0));
				loadedModules.set(daEvent, ScriptHandler.loadModule('events/$daEvent'));
				futureEvents.push(daEvent);
			}
			else
			{
				if (PlayState.SONG != null && CoolUtil.spaceToDash(PlayState.SONG.song.toLowerCase()) == daEvent)
				{
					for (subEvent in Assets.list().filter(list -> list.contains('assets/events/$daEvent')))
					{
						var daSubEvent:String = subEvent.replace('assets/events/$daEvent/', '');

						if (daSubEvent.contains('/'))
							daSubEvent = daSubEvent.replace(daSubEvent.substring(daSubEvent.indexOf('/'), daSubEvent.length), ''); // fancy

						daSubEvent = daSubEvent.substring(0, daSubEvent.indexOf('.', 0));

						loadedModules.set(daSubEvent, ScriptHandler.loadModule('events/$daEvent/$daSubEvent'));
						futureSubEvents.push(daSubEvent);
					}
				}
			}
		}

		futureEvents.sort(function(a, b) return Reflect.compare(a.toLowerCase(), b.toLowerCase()));
		futureSubEvents.sort(function(a, b) return Reflect.compare(a.toLowerCase(), b.toLowerCase()));

		for (i in futureSubEvents)
			eventList.push(i);
		futureEvents.insert(0, '');
		for (i in futureEvents)
			eventList.push(i);

		futureEvents = [];
		futureSubEvents = [];

		eventList.insert(0, '');
	}

	public static function returnDescription(event:String):String
	{
		if (loadedModules.get(event) != null)
		{
			var module:ForeverModule = loadedModules.get(event);
			if (module.exists('returnDescription'))
				return module.get('returnDescription')();
		}
		return '';
	}
}