package template.net
{
	import de.molehill.net.valueObjects.ValueObject;

	public interface IAMFManager
	{
		function send(vo:ValueObject):Boolean;
	}
}