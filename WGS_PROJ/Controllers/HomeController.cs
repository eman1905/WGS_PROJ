using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using WGS_PROJ.Models;

namespace WGS_PROJ.Controllers
{
  public class HomeController : Controller
  {
    private readonly ILogger<HomeController> _logger;
    private readonly WGS_PROJContext dbContext = new WGS_PROJContext();

    public HomeController(ILogger<HomeController> logger)
    {
      _logger = logger;
    }

    public IActionResult Index()
    {
      return View();
    }

    public IActionResult Privacy()
    {
      return View();
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
      return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }

    public IActionResult Invoice(int? id)
    {

      var invoice = dbContext.TrInvoice.Find(id);

      //if (invoice == null) {
      //  return NotFound();
      //}
      
      ViewBag.sales = new SelectList(dbContext.MsSales, "SalesId", "SalesName");
      ViewBag.courier = new SelectList(dbContext.MsCourier, "CourierId", "CourierName");


      return View(invoice);
    }

    [HttpPost]
    public IActionResult Invoice(TrInvoice model)
    {

      return View();
    }
  }
}