---
title: Approach to learn
date: 2024-01-08 05:48:52 +0100
categories: [C#]
tags: [dotnet]
---

Сначала смотрим xunit
код
потом stackoverflow
До того как net стал открыли для публичного доступа
  большинство  специальной технической литературы существововало  так как 2 первые опций отсутсвовали, или из-за неосведомленности что они существуют.
 xmldoc хорош но все таки он для генерации xml и Intellysense, для выборок анализа методов  атрибуты  удобнее
вот например аттрибут
[ActiveIssue("https://github.com/dotnet/runtime/issues/34685", TestRuntimes.Mono)]
D:\src\runtime\src\libraries\System.Diagnostics.Process\tests\ProcessStartInfoTests.cs


namespace Xunit
{
    /// <summary>
    /// Apply this attribute to your test method to specify an active issue.
    /// </summary>
    [TraitDiscoverer("Microsoft.DotNet.XUnitExtensions.ActiveIssueDiscoverer", "Microsoft.DotNet.XUnitExtensions")]
    [AttributeUsage(AttributeTargets.Method | AttributeTargets.Class | AttributeTargets.Assembly, AllowMultiple = true)]
    public class ActiveIssueAttribute : Attribute, ITraitAttribute
    {
        public Type CalleeType { get; private set; }
        public string[] ConditionMemberNames { get; private set; }

        public ActiveIssueAttribute(string issue, TestPlatforms platforms) { }
        public ActiveIssueAttribute(string issue, TargetFrameworkMonikers framework) { }
        public ActiveIssueAttribute(string issue, TestRuntimes runtimes) { }
        public ActiveIssueAttribute(string issue, TestPlatforms platforms = TestPlatforms.Any, TargetFrameworkMonikers framework = TargetFrameworkMonikers.Any, TestRuntimes runtimes = TestRuntimes.Any) { }
        public ActiveIssueAttribute(string issue, Type calleeType, params string[] conditionMemberNames)
        {
            CalleeType = calleeType;
            ConditionMemberNames = conditionMemberNames;
        }
    }
}

https://kenbonny.net/creating-a-custom-xunit-trait
[TraitDiscoverer("Microsoft.DotNet.XUnitExtensions.ActiveIssueDiscoverer", "Microsoft.DotNet.XUnitExtensions")]