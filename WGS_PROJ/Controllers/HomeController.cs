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
      ViewBag.product = dbContext.MsProduct.ToList();

      return View(invoice);
    }

    public IActionResult Product()
    {
      var model = dbContext.MsProduct.ToList();
      return PartialView("_product", model);
    }

    [HttpPost]
    public IActionResult Invoice(TrInvoice model)
    {
      using (var transcation = dbContext.Database.BeginTransaction())
      {
        if (model.InvoiceId == 0)
        {
          //input baru
          dbContext.TrInvoice.Add(model);

          try
          {
            dbContext.SaveChanges();
            transcation.Commit();
          }
          catch (Exception e)
          {
            transcation.Rollback();
            throw e;
          }

        }
        else
        {
          TrInvoice old = dbContext.TrInvoice.Find(model.InvoiceId);

          //hapus jika tidak ada
          foreach (var existingChild in old.TrInvoiceDetail.ToList())
          {
            if (!model.TrInvoiceDetail.Any(c => c.InvoiceDetailId == existingChild.InvoiceDetailId))
              dbContext.TrInvoiceDetail.Remove(existingChild);
          }

          //jika ada item baru
          foreach (var p in model.TrInvoiceDetail)
          {
            var existingChild = old.TrInvoiceDetail
        .Where(c => c.InvoiceDetailId == p.InvoiceDetailId)
        .SingleOrDefault();

            if (existingChild != null)
              // Update child
              dbContext.Entry(existingChild).CurrentValues.SetValues(p);
            else
            {
              p.InvoiceId = model.InvoiceId;
              old.TrInvoiceDetail.Add(p);
            }
          }

          old.InvoiceShipTo = model.InvoiceShipTo;
          old.InvoiceTo = model.InvoiceTo;
          old.InvoiceDate = model.InvoiceDate;
          old.PaymentType = model.PaymentType;
          old.SalesId = model.SalesId;
          old.CourierId = old.CourierId;
          try
          {
            dbContext.SaveChanges();
            transcation.Commit();
          }
          catch (Exception e)
          {
            transcation.Rollback();
            throw e;
          }
        }
      }


      ViewBag.sales = new SelectList(dbContext.MsSales, "SalesId", "SalesName");
      ViewBag.courier = new SelectList(dbContext.MsCourier, "CourierId", "CourierName");
      ViewBag.product = dbContext.MsProduct.ToList();
      return RedirectToAction("Invoice", new { id = model.InvoiceId });
    }

    [HttpGet]
    public IActionResult getCourier(int id)
    {
      var courier = dbContext.MsCourier.FindAsync(id);

      if (courier == null)
      {
        return NotFound();
      }

      return Ok(courier);
    }
  }
}
