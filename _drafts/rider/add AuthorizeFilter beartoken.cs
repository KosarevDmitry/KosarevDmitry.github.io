//https://stackoverflow.com/questions/41972518/how-to-add-global-authorizefilter-or-authorizeattribute-in-asp-net-core
//https://stackoverflow.com/questions/56152933/how-does-authorizefilter-work-with-authorizeattribute-applied-to-page

//register a filter globally (for all controllers and actions)
AuthorizationPolicy policy = new AuthorizationPolicyBuilder(JwtBearerDefaults.AuthenticationScheme).RequireAuthenticatedUser().Build();

services.AddSingleton(policy);

services.AddControllers(options =>
{
    options.Filters.Add(typeof(BearerTokenAuthorizationFilter));
});


public class BearerTokenAuthorizationFilter : AuthorizeFilter
{
  private readonly AuthorizationPolicy _policy;

  public BearerTokenAuthorizationFilter(AuthorizationPolicy policy) : base(policy)
  {
      _policy = policy;
  }

  public override async Task OnAuthorizationAsync(AuthorizationFilterContext context)
  {
    //Use the policy here...
  }
}

-------------
for MVC
services.AddMvc(options =>
{
    options.Filters.Add(typeof(AuthorizeFilter));
});

-------------------------

var policy = new AuthorizationPolicyBuilder().RequireAuthenticatedUser().RequireRole("Admin", "SuperUser").Build();


services.AddMvc(options =>
{
    options.Filters.Add(new AuthorizeFilter(policy));
});

---------------------------



