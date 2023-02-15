namespace MainLeaf.OcarinaOfTime.Player
{
    public static class PlayerProgress
    {
        private static int _points;

        public static void AddPoints(int pointsAmount)
        {
            _points += pointsAmount;
        }

        public static int GetPoints() => _points;

        public static void ResetPoints() => _points = 0;
    }
}