using Microsoft.AspNetCore.Mvc;
using TuyenDungViecLam.Services;
using TuyenDungViecLam.Models;

namespace TuyenDungViecLam.Controllers
{
    public class AdminController : Controller
    {
        private readonly IDataService _dataService;

        public AdminController(IDataService dataService)
        {
            _dataService = dataService;
        }

        public async Task<IActionResult> Index()
        {
            if (HttpContext.Session.GetString("UserRole") != "Admin")
            {
                return RedirectToAction("Login", "Account");
            }

            var jobs = await _dataService.GetJobsAsync();
            var employers = await _dataService.GetEmployersAsync();
            var candidates = await _dataService.GetCandidatesAsync();
            var applications = await _dataService.GetApplicationsAsync();

            ViewBag.TotalJobs = jobs.Count;
            ViewBag.TotalEmployers = employers.Count;
            ViewBag.TotalCandidates = candidates.Count;
            ViewBag.TotalApplications = applications.Count;

            return View();
        }

        public async Task<IActionResult> Jobs()
        {
            if (HttpContext.Session.GetString("UserRole") != "Admin")
            {
                return RedirectToAction("Login", "Account");
            }

            var jobs = await _dataService.GetJobsAsync();
            return View(jobs);
        }

        public async Task<IActionResult> Employers()
        {
            if (HttpContext.Session.GetString("UserRole") != "Admin")
            {
                return RedirectToAction("Login", "Account");
            }

            var employers = await _dataService.GetEmployersAsync();
            return View(employers);
        }

        public async Task<IActionResult> Candidates()
        {
            if (HttpContext.Session.GetString("UserRole") != "Admin")
            {
                return RedirectToAction("Login", "Account");
            }

            var candidates = await _dataService.GetCandidatesAsync();
            return View(candidates);
        }

        public async Task<IActionResult> Applications()
        {
            if (HttpContext.Session.GetString("UserRole") != "Admin")
            {
                return RedirectToAction("Login", "Account");
            }

            var applications = await _dataService.GetApplicationsAsync();
            return View(applications);
        }
    }
}