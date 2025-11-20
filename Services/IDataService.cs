using TuyenDungViecLam.Models;

namespace TuyenDungViecLam.Services
{
    public interface IDataService
    {
        Task<List<Job>> GetJobsAsync();
        Task<Job?> GetJobByIdAsync(string id);
        Task<List<Employer>> GetEmployersAsync();
        Task<Employer?> GetEmployerByIdAsync(string id);
        Task<List<Category>> GetCategoriesAsync();
        Task<List<Candidate>> GetCandidatesAsync();
        Task<List<Application>> GetApplicationsAsync();
        Task<List<Job>> SearchJobsAsync(string? keyword, string? location, string? category);
    }
}