using System;
using System.Diagnostics;
using System.Reflection;

namespace DispThisVerNetFx
{
	internal class Program
	{
		static void Main( string[] args )
		{
			var assembly = Assembly.GetExecutingAssembly();
			FileVersionInfo fvi = FileVersionInfo.GetVersionInfo( assembly.Location );
			Console.WriteLine( $"File version: {fvi.FileVersion}" );
		}
	}
}
