using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Hosting.WindowsServices;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace WebApp
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");
            var runAsService = !(Debugger.IsAttached || args.Contains("--console") || environment == "Development");
            var builder = CreateWebHostBuilder(args.Where(arg => arg != "--console").ToArray());

            if (runAsService)
            {
                var pathToExe = Process.GetCurrentProcess().MainModule.FileName;
                var pathToContentRoot = Path.GetDirectoryName(pathToExe);
                builder.UseContentRoot(pathToContentRoot);
            }

            var host = builder.Build();

            if (runAsService)
            {
                host.RunAsService();
            }
            else
            {
                host.Run();
            }
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .ConfigureAppConfiguration((hostContext, configBuilder) =>
                {
                    //configure the app here
                 })
                .UseStartup<Startup>();
    }
}
