SELECT *
FROM PortfolioProject..CovidDeaths
order by 3,4

--SELECT *
--FROM PortfolioProject..CovidVaccination
--order by 3,4

--SELECT *
--FROM PortfolioProject..GlobalTestPerCountry
--order by 3,4

--Select data that we are going to be using
select country, New_cases, Cumulative_cases, New_deaths, Cumulative_deaths
from PortfolioProject..CovidDeaths
order by 1,3

-- Change 0 to Null so it can perform division calculations 

update PortfolioProject..CovidDeaths 
set Cumulative_deaths=NULL 
where Cumulative_deaths=0

update PortfolioProject..CovidDeaths 
set Cumulative_cases=NULL 
where Cumulative_cases=0

--SELECT *
--FROM PortfolioProject..CovidDeaths
--order by 3,4

--Looking at the Cumulative_cases vs Cumulative_deaths
--Trying to understand the percentage of people who died after getting diagnosed with covid

select country, Cumulative_cases, Cumulative_deaths, (Cumulative_deaths/Cumulative_cases)*100 as Death_Percentage
from PortfolioProject..CovidDeaths
order by 1,2

-- Checking for Nigeria Only

select country, Cumulative_cases, Cumulative_deaths, (Cumulative_deaths/Cumulative_cases)*100 as Death_Percentage
from PortfolioProject..CovidDeaths
where Country like 'Nigeria'
order by 1,2

--Looking at the Countries with the Highest Infection Rate Compared to their Deaths

select country, MAX(Cumulative_cases) as HighestInfectionCount, MAX((Cumulative_deaths/Cumulative_cases))*100 as HighestDeathInfected
from PortfolioProject..CovidDeaths
group by country
order by HighestDeathInfected desc

--Looking at the Countries with the Highest Death Count
select country, max(cast(Cumulative_deaths as int)) as HighestDeathCount
from PortfolioProject..CovidDeaths
group by country
order by HighestDeathCount desc

--Looking at the WHO_region with the Highest Death Count
select WHO_region, max(cast(Cumulative_deaths as int)) as HighestDeathCount
from PortfolioProject..CovidDeaths
group by WHO_region
order by HighestDeathCount desc

--Total cases per day in the world

select Date_reported, sum(New_cases) as cases_per_day
from PortfolioProject..CovidDeaths
group by Date_reported 
order by Date_reported asc

--Joining The coviddeaths and covidvaccination country and date 
SELECT *
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
 on dea.Country = vac.COUNTRY
   AND dea.Date_reported = vac.DATE_UPDATED
  

--Creating a new table on Vaccination 
 
SELECT dea.Country, dea.WHO_region, vac.DATE_UPDATED, vac.TOTAL_VACCINATIONS, vac.PERSONS_FULLY_VACCINATED
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
 on dea.Country = vac.COUNTRY
   AND dea.Date_reported = vac.DATE_UPDATED
  
-- Continent with the most persons vaccinated

SELECT dea.WHO_region, MAX(vac.PERSONS_FULLY_VACCINATED) as Highest_Vaccinated_Continent
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
 on dea.Country = vac.COUNTRY
   AND dea.Date_reported = vac.DATE_UPDATED
   group by dea.WHO_region
   order by Highest_Vaccinated_Continent desc



-- Creating view to store data for later visualizations

CREATE VIEW Highest_Vaccinated_Continent AS
SELECT dea.WHO_region, MAX(vac.PERSONS_FULLY_VACCINATED) as Highest_Vaccinated_Continent
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
 on dea.Country = vac.COUNTRY
   AND dea.Date_reported = vac.DATE_UPDATED
   group by dea.WHO_region
  --order by Highest_Vaccinated_Continent desc

  select *
  from Highest_Vaccinated_Continent









